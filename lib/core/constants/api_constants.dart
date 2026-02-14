class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://missouripoisoncenter.org';

  static const String versionEndpoint = '/wp-json/pm/v1/version';

  static const String poisonsEndpoint = '/wp-json/pm/v1/posts';

  static const Duration requestTimeout = Duration(seconds: 10);

  static const Duration connectivityCheckTimeout = Duration(seconds: 2);

  static const String assetsPostsPath = 'assets/data/posts.json';
}
