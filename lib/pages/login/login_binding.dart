/*
 * @Description: 登录
 * @Author: iamsmiling
 * @Date: 2021-09-18 15:24:36
 * @LastEditTime: 2021-09-18 15:29:35
 */
import 'package:get/get.dart';
import 'package:dc_flutter_cli/pages/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
