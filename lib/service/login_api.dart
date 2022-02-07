/*
 * @Description: 登录相关
 * @Author: iamsmiling
 * @Date: 2021-09-18 15:39:50
 * @LastEditTime: 2021-09-18 15:43:35
 */
import 'package:dc_flutter_cli/http/http.dart';
import 'package:dc_flutter_cli/model/user/user_session_model.dart';
import 'package:dc_flutter_cli/service/api_path.dart';

abstract class LoginAPI {
  /// 密码登录(包含手机或邮箱,name传手机或邮箱)
  static Future<UserSessionModel> loginPWD(
      {required String password,
      required String name,
      String areaCode = "86"}) {
    return Http.instance
        .post(ApiRequest(LOGIN,
            formData: {
              "areaCode": areaCode,
              "name": name,
              "password": password,
              "systemId": 2
            },
            loading: true))
        .then((value) => UserSessionModel.fromJson(value.data));
  }
}
