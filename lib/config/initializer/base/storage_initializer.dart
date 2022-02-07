/*
 * @Description: 本地存储初始化器
 * @Author: iamsmiling
 * @Date: 2021-09-18 14:13:58
 * @LastEditTime: 2022-01-28 13:01:40
 */
import 'package:dc_flutter_cli/app_env.dart';
import 'package:dc_flutter_cli/storage/sp_util.dart';
import 'base_initializer.dart';

class StorageInitializer extends BaseInitilizer {
  @override
  Future initialize(AppEnvironment env) async {
    /// 等待Sp初始化完成。
    await SpUtil.init();
  }
}
