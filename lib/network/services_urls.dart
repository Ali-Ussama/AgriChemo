class ServicesURLs {
  static const productionEnvironment = "https://example.com/api/";
  static const productionEnvironmentWithoutHttp = "example.com";
  static const productionEnvironmentPort = 5200;
  static const productionEnvironmentScheme = 'https';

  static const developmentStEnvironment = "http://example.com/api/";
  static const developmentStEnvironmentWithoutHttp = "example.com";
  static const developmentStEnvironmentPort = 5900;
  static const developmentStEnvironmentScheme = 'http';

  static const developmentEnvironment = developmentStEnvironment;
  static const developmentEnvironmentWithoutHttp = developmentStEnvironmentWithoutHttp;
  static const developmentEnvironmentPort = developmentStEnvironmentPort;
  static const developmentEnvironmentScheme = developmentStEnvironmentScheme;

  // static const developmentEnvironment = productionEnvironment;
  // static const developmentEnvironmentWithoutHttp = productionEnvironmentWithoutHttp;
  // static const developmentEnvironmentPort = productionEnvironmentPort;
  // static const developmentEnvironmentScheme = productionEnvironmentScheme;

}
