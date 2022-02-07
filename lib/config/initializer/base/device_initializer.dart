/*
 * @Description: app包信息、手机系统等
 * @Author: iamsmiling
 * @Date: 2021-09-18 16:56:57
 * @LastEditTime: 2022-01-19 17:38:46
 */

// e.g. "iPod7,1"
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:dc_flutter_cli/config/app_config.dart';
import 'package:dc_flutter_cli/app_env.dart';

import 'base_initializer.dart';

class DeviceInitializer extends BaseInitilizer {
  @override
  Future initialize(AppEnvironment env) async {
    AppConfig.packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AppConfig.androidInfo = await deviceInfo.androidInfo;
    }
    if (GetPlatform.isIOS) {
      AppConfig.iosInfo = await deviceInfo.iosInfo;
    }
  }
}
