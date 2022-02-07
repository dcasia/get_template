/*
 * @Description: 请求错误
 * @Author: iamsmiling
 * @Date: 2021-09-03 14:32:51
 * @LastEditTime: 2022-02-07 16:08:05
 */
/// 请求错误
part of http;

class BadRequestException extends BaseException {
  BadRequestException(String code, String message, Response? response)
      : super(code: code, message: message, response: response);
}
