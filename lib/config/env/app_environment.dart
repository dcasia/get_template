/*
 * @Description: 环境相关
 * @Author: iamsmiling
 * @Date: 2021-09-18 10:58:33
 * @LastEditTime: 2021-09-18 16:14:36
 */
/*
 * @Description: app配置类
 * @Author: iamsmiling
 * @Date: 2021-09-06 19:49:39
 * @LastEditTime: 2021-09-07 11:55:49
 */

enum AppEnvironment {
  ///线上环境
  product,

  ///测试环境
  test,

  ///开发环境
  develop
}

extension AppEnvironmentHost on AppEnvironment {
  String get APIHOST =>
      {
        AppEnvironment.develop: "https://api.dev.taiyi-tech.com",
        AppEnvironment.product: "https://api.taiyi-tech.com",
        AppEnvironment.test: "https://api.test.taiyi-tech.com"
      }[this] ??
      "";
  String get WEBVIEW_HOST =>
      {
        AppEnvironment.develop: "https://app.dev.taiyi-tech.com",
        AppEnvironment.product: "https://app.taiyi-tech.com",
        AppEnvironment.test: "https://app.test.taiyi-tech.com"
      }[this] ??
      "";
}
