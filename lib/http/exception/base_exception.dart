/*
 * @Description: Dio异常
 * @Author: iamsmiling
 * @Date: 2021-09-03 14:54:21
 * @LastEditTime: 2022-02-07 16:09:24
 */
part of http;

abstract class BaseException {
  final String message;
  final String code;
  final Response? response;

  BaseException(
      {required this.code, required this.message, required this.response});

  factory BaseException.create(DioError error) {
    Response? response = error.response;

    if (response == null) {
      return BadRequestException("", "无法连接服务器", error.response);
    }
    String code = "${response.statusCode}";
    switch (error.type) {
      case DioErrorType.cancel:
        {
          throw BadRequestException(code, "请求取消", error.response);
        }
      case DioErrorType.connectTimeout:
        {
          throw BadRequestException(code, "连接超时", error.response);
        }
      case DioErrorType.sendTimeout:
        {
          throw BadRequestException(code, "请求超时", error.response);
        }

      case DioErrorType.receiveTimeout:
        {
          throw BadRequestException(code, "响应超时", error.response);
        }
      case DioErrorType.response:
        {
          try {
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (code) {
              case "400":
                {
                  throw BadRequestException(code, "请求语法错误", error.response);
                }

              case "401":
                {
                  throw UnauthorisedException(code, "没有权限", error.response);
                }

              case "403":
                {
                  throw UnauthorisedException(code, "服务器拒绝执行", error.response);
                }

              case "404":
                {
                  throw UnauthorisedException(code, "无法连接服务器", error.response);
                }

              case "405":
                {
                  throw UnauthorisedException(code, "请求方法被禁止", error.response);
                }

              case "500":
                {
                  throw UnauthorisedException(code, "服务器内部错误", error.response);
                }

              case "502":
                {
                  throw UnauthorisedException(code, "无效的请求", error.response);
                }

              case "503":
                {
                  throw UnauthorisedException(code, "服务器挂了", error.response);
                }

              case "505":
                {
                  throw UnauthorisedException(
                      code, "不支持HTTP协议请求", error.response);
                }

              default:
                {
                  throw UnkonwException(code, "未知的http异常", error.response);
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  // return AppException(
                  //     errCode, error.response?.statusMessage ?? '');
                }
            }
          } on Exception catch (exception) {
            // return error.error;
            throw exception;
          }
        }

      default:
        {
          throw error.error;
        }
    }
  }
}
