/*
 * @Description: 未认证错误
 * @Author: iamsmiling
 * @Date: 2021-09-03 14:35:59
 * @LastEditTime: 2022-02-07 16:08:49
 */
part of http;

class UnauthorisedException extends BaseException {
  UnauthorisedException(String code, String message, Response? response)
      : super(code: code, message: message, response: response);
}
