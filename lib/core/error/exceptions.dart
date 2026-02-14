class UnexpectedException implements Exception {
  final int errorCode;
  final String message;

  UnexpectedException({required this.errorCode, this.message = ''});
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}
