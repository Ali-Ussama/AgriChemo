class ServicesURLs {
  static const production_environment = "https://example.com/api/";
  static const production_environment_without_http = "example.com";
  static const production_environment_port = 5200;
  static const production_environment_scheme = 'https';

  static const development_st_environment = "http://example.com/api/";
  static const development_st_environment_without_http = "example.com";
  static const development_st_environment_port = 5900;
  static const development_st_environment_scheme = 'http';

  static const development_environment = development_st_environment;
  static const development_environment_without_http = development_st_environment_without_http;
  static const development_environment_port = development_st_environment_port;
  static const development_environment_scheme = development_st_environment_scheme;

  // static const development_environment = production_environment;
  // static const development_environment_without_http = production_environment_without_http;
  // static const development_environment_port = production_environment_port;
  // static const development_environment_scheme = production_environment_scheme;

}
