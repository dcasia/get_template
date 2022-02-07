enum AppEnvironment {
  ///线上环境
  prod,

  ///测试环境
  test,

  ///开发环境
  debug
}

extension AppEnvironmentHost on AppEnvironment {
  String get APIHOST =>
      {
        AppEnvironment.debug: "https://api.dev.taiyi-tech.com",
        AppEnvironment.prod: "https://api.taiyi-tech.com",
        AppEnvironment.test: "https://api.test.taiyi-tech.com"
      }[this] ??
      "";
  String get WEBVIEW_HOST =>
      {
        AppEnvironment.debug: "https://app.dev.taiyi-tech.com",
        AppEnvironment.prod: "https://app.taiyi-tech.com",
        AppEnvironment.test: "https://app.test.taiyi-tech.com"
      }[this] ??
      "";
}

AppEnvironment getAppEnv(String env) {
  if (env == AppEnvironment.prod.name) {
    return AppEnvironment.prod;
  } else if (env == AppEnvironment.test.name) {
    return AppEnvironment.test;
  }
  return AppEnvironment.debug;
}
