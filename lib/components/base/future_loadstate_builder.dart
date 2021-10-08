/*
 * @Description: 
 * @Author: iamsmiling
 * @Date: 2021-09-18 14:34:27
 * @LastEditTime: 2021-10-08 17:12:43
 */
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

onJsonModelizeError(dynamic error, StackTrace stackTrace) {
  // print(stackTrace);
  LogUtil.e(stackTrace);

  // return JsonModelizeException();
}

abstract class BaseFutureLoadStateController<T> extends GetxController
    with StateMixin<T>, WidgetsBindingObserver {
  Future<T> loadData({Map? params});

  @override
  void onInit() {
    _fetch();
    WidgetsBinding.instance!.addObserver(this);
    super.onInit();
  }

  Future<T> fetchData() => _fetch();
  Future<T> _fetch() {
    change(null, status: RxStatus.loading());
    return _loadData();
  }

  Future<T> _loadData() {
    return loadData().then((value) {
      if (value is Iterable && value.isEmpty) {
        change(value, status: RxStatus.empty());
      } else {
        change(value, status: RxStatus.success());
      }
      return value;
    }, onError: onJsonModelizeError).catchError((err, s) {
      change(null, status: RxStatus.error());
      LogUtil.e(err);
      print(s);
      throw err;
    }).whenComplete(update);
  }

  Future retry() {
    return _fetch();
  }

  Future? onRefreshData() => _loadData();

  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        _fetch();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.detached:

        /// 申请将暂时暂停
        break;
    }
  }

  ///回到前台刷新数据
  Future? onAppResumed() => onRefreshData();
}

///带下拉刷新 上拉加载更多功能的controller基类
abstract class PullToRefreshLoadStateController<T>
    extends BaseFutureLoadStateController<T> {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super._fetch().then((value) {
      refreshController = RefreshController(initialRefresh: false);
      scrollController = ScrollController();
      return value;
    });
    super.onInit();
  }

  @override
  void onReady() {
    refreshController = new RefreshController();
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future onLoad() {
    return Future.value();
  }

  Future? onRefreshData() {
    return refreshController.requestRefresh()?.then((value) {
      return loadData().then((value) {
        if (value is Iterable && value.isEmpty) {
          change(value, status: RxStatus.empty());
        }
        refreshController.refreshCompleted();
      });
    }).catchError((err) {
      refreshController.refreshFailed();
    }).whenComplete(update);
  }

  Future<T> onLoadData() {
    return loadData().then((value) {
      if (value is Iterable && value.isEmpty) {
        refreshController.loadNoData();
        // change(value, status: RxStatus.empty());
      } else {
        refreshController.loadComplete();
        // change(value, status: RxStatus.success());
      }
      return value;
    }, onError: onJsonModelizeError).catchError((err, s) {
      // change(null, status: RxStatus.error());
      refreshController.loadComplete();
      LogUtil.e(err);
      print(s);
    });
  }
}

typedef GetControllerScrollBuilder<T extends DisposableInterface> = Widget
    Function(T controller);

class PullToRefreshStateBuilder<T extends PullToRefreshLoadStateController>
    extends StatelessWidget {
  final GetControllerBuilder<T> builder;
  final bool enablePullDown;
  final bool enablePullUp;
  final Object? id;
  final String? tag;
  PullToRefreshStateBuilder(
      {required this.builder,
      this.enablePullDown = true,
      this.enablePullUp = true,
      this.id,
      this.tag});
  @override
  Widget build(BuildContext context) {
    final T controller = Get.find<T>(tag: tag);
    return SmartRefresher(
      controller: controller.refreshController,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      onRefresh: controller.onRefreshData,
      scrollController: controller.scrollController,
      child: controller.obx(
          (state) => GetBuilder<T>(tag: tag, id: id, builder: builder),
          onError: (String? s) => Center(
                child: GestureDetector(
                  onTap: controller.retry,
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.error), Text("点击重试")],
                    ),
                  ),
                ),
              ),
          onLoading: Center(child: CupertinoActivityIndicator())),
    );
  }
}

class FutureLoadStateBuilder<T extends BaseFutureLoadStateController>
    extends StatelessWidget {
  final GetControllerBuilder<T> builder;
  final Object? id;
  final String? tag;
  FutureLoadStateBuilder({required this.builder, this.tag, this.id});
  @override
  Widget build(BuildContext context) {
    final T controller = Get.find<T>(tag: tag);
    return controller.obx(
        (state) => GetBuilder<T>(
              tag: tag,
              id: id,
              builder: builder,
            ),
        onError: (String? s) => Center(
              child: GestureDetector(
                onTap: controller.retry,
                child: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.error), Text("点击重试")],
                  ),
                ),
              ),
            ),
        onEmpty: SizedBox.shrink(),
        onLoading: Center(child: CupertinoActivityIndicator()));
  }
}
