/*
 * @Description: app配置
 * @Author: iamsmiling
 * @Date: 2021-09-18 16:53:52
 * @LastEditTime: 2022-02-07 17:32:09
 */

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

import '../app_env.dart';

abstract class AppConfig {
  static const String _environment =
      String.fromEnvironment("DART_DEFINE_APP_ENV", defaultValue: "debug");
  static AppEnvironment get environment => getAppEnv(_environment);
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;

  static PackageInfo? packageInfo;

  static String? get systemVersion {
    if (GetPlatform.isAndroid) {
      return androidInfo?.version.codename;
    }
    return iosInfo?.systemVersion;
  }
}
