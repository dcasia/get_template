/*
 * @Description: 初始化管理统一初始化
 * @Author: iamsmiling
 * @Date: 2021-09-18 14:20:45
 * @LastEditTime: 2022-02-07 17:34:51
 */
import 'package:dc_flutter_cli/app_env.dart';
import 'package:dc_flutter_cli/config/initializer/base/device_initializer.dart';
import 'base/base_initializer.dart';
import 'base/logger_intilaizer.dart';
import 'base/storage_initializer.dart';
import 'base/system_initializer.dart';

abstract class InitializerManager<T extends BaseInitilizer> {
  static List<BaseInitilizer> _initializers = [
    ///SpStorage需要最先初始化
    StorageInitializer(),
    SystemInitializer(),

    ///是否允许打印
    LoggerInitializer(),
    DeviceInitializer(),
  ];

  ///进行统一初始化
  static Future initialize(AppEnvironment env) async {
    for (BaseInitilizer i in _initializers) {
      await i.initialize(env);
    }
  }
}
