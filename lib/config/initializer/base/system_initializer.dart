/*
 * @Description: 状态栏颜色
 * @Author: iamsmiling
 * @Date: 2021-09-18 14:18:42
 * @LastEditTime: 2021-09-18 14:25:04
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dc_flutter_cli/app_env.dart';

import 'base_initializer.dart';

class SystemInitializer extends BaseInitilizer {
  @override
  Future initialize(AppEnvironment env) async {
    ///设置透明状态栏
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    // 强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
