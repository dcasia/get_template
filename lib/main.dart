/*
 * @Description: 
 * @Author: iamsmiling
 * @Date: 2021-09-18 10:42:46
 * @LastEditTime: 2022-02-07 17:50:13
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dc_flutter_cli/app_env.dart';
import 'package:dc_flutter_cli/pages/home/home_binding.dart';
import 'package:dc_flutter_cli/theme/app_theme.dart';

import 'config/app_config.dart';
import 'config/initializer/initializer_manager.dart';
import 'pages/login/login_binding.dart';
import 'router/app_router.dart';
import 'app_env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitializerManager.initialize(AppConfig.environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),
      footerTriggerDistance: 56,
      footerBuilder: () => ClassicFooter(
        loadingText: '正在加载',
        noDataText: '我也是有底线的哦',
        failedText: '加载失败',
        canLoadingText: '上拉加载更多',
        idleText: '上拉加载更多',
        height: 50,
        loadingIcon: SizedBox(
          width: 25,
          height: 25,
          child: CupertinoActivityIndicator(),
        ),
      ),
      child: GetMaterialApp(
        title: 'Cli',
        initialBinding: AppRouter.initial == AppRoutes.home
            ? HomeBinding()
            : LoginBinding(),
        initialRoute: AppRouter.initial,
        getPages: AppRouter.pages,
        defaultTransition: Transition.cupertino,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,
        debugShowCheckedModeBanner:
            AppConfig.environment == AppEnvironment.debug,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                boldText: false,
                textScaleFactor: GetPlatform.isAndroid ? 0.88 : 1.0),
            child: FlutterEasyLoading(child: child),
          );
        },
        localizationsDelegates: [
          // 这行是关键
          RefreshLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('zh', 'CH'),
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          //print("change language");
          return locale;
        },
      ),
    );
  }
}
