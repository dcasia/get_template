/*
 * @Description: 登录逻辑
 * @Author: iamsmiling
 * @Date: 2021-09-18 15:23:38
 * @LastEditTime: 2021-09-18 15:44:17
 */
import 'package:get/get.dart';
import 'package:dc_flutter_cli/service/login_api.dart';

class LoginController extends GetxController {
  Future login() {
    return LoginAPI.loginPWD(password: "121212", name: "1212");
  }
}
