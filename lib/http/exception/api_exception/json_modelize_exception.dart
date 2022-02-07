/*
 * @Description: json转模型异常
 * @Author: iamsmiling
 * @Date: 2021-09-03 15:31:40
 * @LastEditTime: 2022-02-07 16:07:19
 */
part of http;

class JsonModelizeException extends BaseApiException {
  JsonModelizeException({
    String code = "",
    String message = "json转模型失败",
    required Response? response,
  }) : super(code, message, response);

  @override
  void onException() {
    print("json转model时出现异常");
  }
}
