/*
 * @Description: app初始化器的基类
 * @Author: iamsmiling
 * @Date: 2021-09-18 11:02:17
 * @LastEditTime: 2021-09-18 11:02:17
 */

import 'package:dc_flutter_cli/app_env.dart';

abstract class BaseInitilizer {
  Future initialize(AppEnvironment env);
}
