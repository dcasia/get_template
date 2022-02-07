/*
 * @Description: 数据非法
 * @Author: iamsmiling
 * @Date: 2021-09-04 09:30:04
 * @LastEditTime: 2022-02-07 16:07:01
 */

part of http;

class DataInvalidException extends BaseApiException {
  DataInvalidException({
    String code = "",
    String message = "服务端返回数据异常",
    required Response? response,
  }) : super(code, message, response);

  @override
  void onException() {
    print("服务端返回数据异常");
  }
}
