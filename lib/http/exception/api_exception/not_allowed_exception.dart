/*
 * @Description: 不允许访问
 * @Author: iamsmiling
 * @Date: 2021-09-06 14:52:39
 * @LastEditTime: 2022-02-07 16:07:32
 */
part of http;

class NotAllowedException extends BaseApiException {
  NotAllowedException(
      {String code = "",
      String message = "服务端返回数据异常",
      required Response? response})
      : super(
          code,
          message,
          response,
        );

  @override
  void onException() {
    print("服务端返回数据异常");
  }
}
