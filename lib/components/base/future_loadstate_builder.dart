/*
 * @Description: 
 * @Author: iamsmiling
 * @Date: 2021-09-18 14:34:27
 * @LastEditTime: 2022-02-07 17:44:52
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:developer' as developer;

onJsonModelizeError(dynamic error, StackTrace stackTrace) {
  // print(stackTrace);
  developer.log("$error", stackTrace: stackTrace);

  // return JsonModelizeException();
}

///带数据加载，但不监听app前后台切换
abstract class BaseFutureLoadStateController<T> extends GetxController
    with StateMixin<T> {
  Future<T> loadData({Map? params});

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<T> fetchData() {
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
      developer.log("", stackTrace: err);
      print(s);
      throw err;
    }).whenComplete(update);
  }

  Future retry() {
    return fetchData();
  }

  Future? onRefreshData() => _loadData();
}

///带下拉刷新 上拉加载更多功能的controller基类
abstract class PullToRefreshLoadStateController<T>
    extends BaseFutureLoadStateController<T> {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPage = double.maxFinite ~/ 1;

  @override
  void onInit() {
    super.fetchData().then((value) {
      refreshController = RefreshController(initialRefresh: false);
      scrollController = ScrollController();
      return value;
    });
    super.onInit();
  }

  @override
  void onReady() {
    refreshController = RefreshController();
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
    page = 1;
    return refreshController.requestRefresh()?.then((value) {
      return loadData(params: {'page': 1}).then((value) {
        if (value is Iterable && value.isEmpty) {
          change(value, status: RxStatus.empty());
        }
        refreshController.refreshCompleted();
      });
    }).catchError((err) {
      refreshController.refreshFailed();
    }).whenComplete(update);
  }

  Future<T>? onLoadData() {
    if (page > totalPage) {
      refreshController.loadNoData();
      return null;
    }
    page++;
    return loadData(params: {'page': page}).then((value) {
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
      page--;
      refreshController.loadFailed();
      developer.log("", stackTrace: err);
      print(s);
    });
  }
}

typedef GetControllerScrollBuilder<T extends DisposableInterface> = Widget
    Function(T controller);

class PullToRefreshStateBuilder<T extends PullToRefreshLoadStateController>
    extends GetView<T> {
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
    extends GetView<T> {
  final GetControllerBuilder<T> builder;
  final Object? id;
  final String? tag;
  FutureLoadStateBuilder({required this.builder, this.tag, this.id});
  @override
  Widget build(BuildContext context) {
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
