/*
 * @Description: api相关的异常
 * @Author: iamsmiling
 * @Date: 2021-09-03 14:22:11
 * @LastEditTime: 2022-02-07 16:06:43
 */
part of http;

abstract class BaseApiException extends BaseException {
  final String message;
  final String code;
  final Response? response;

  BaseApiException(this.code, this.message, this.response)
      : super(code: code, message: message, response: response);
  void onException();
}
