/*
 * @Description: 未知的Dio请求异常
 * @Author: iamsmiling
 * @Date: 2021-09-03 14:48:40
 * @LastEditTime: 2022-02-07 16:09:07
 */
part of http;

class UnkonwException extends BaseException {
  UnkonwException(String code, String message, Response? response)
      : super(code: code, message: message, response: response);
}
