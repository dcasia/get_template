/*
 * @Description: app路由与页面关联
 * @Author: iamsmiling
 * @Date: 2021-09-18 15:01:42
 * @LastEditTime: 2021-09-18 15:30:28
 */
library app_router;

import 'package:flustars/flustars.dart';
import 'package:get/route_manager.dart';
import 'package:ty_flutter_cli/constants/sp_key.dart';
import 'package:ty_flutter_cli/pages/404/unknown_page.dart';
import 'package:ty_flutter_cli/pages/home/home_binding.dart';
import 'package:ty_flutter_cli/pages/home/home_page.dart';
import 'package:ty_flutter_cli/pages/login/login_binding.dart';
import 'package:ty_flutter_cli/pages/login/login_page.dart';
part 'app_routes.dart';

abstract class AppRouter {
  static bool get hasLogin =>
      SpUtil.getString(SpKey.ACCESS_SESSION)?.isNotEmpty ?? false;
  static String get initial => hasLogin ? AppRoutes.home : AppRoutes.login;

  static final pages = [
    GetPage(name: AppRoutes.unknown, page: () => UnknownPage()),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: AppRoutes.home, page: () => HomePage(), binding: HomeBinding())
  ];
}
