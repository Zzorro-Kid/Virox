import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../error/exceptions.dart';

class BaseRemoteDataSource {
  final http.Client client;

  const BaseRemoteDataSource({required this.client});

  Map<String, dynamic> handleObjectResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body.isEmpty ? '{}' : response.body;

    switch (statusCode) {
      case 200:
        return jsonDecode(responseBody) as Map<String, dynamic>;
      default:
        _handleError(responseBody: responseBody, statusCode: statusCode);
        return {};
    }
  }

  List<dynamic> handleListResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body.isEmpty ? '[]' : response.body;

    switch (statusCode) {
      case 200:
        return jsonDecode(responseBody) as List<dynamic>;
      default:
        _handleError(responseBody: responseBody, statusCode: statusCode);
        return [];
    }
  }

  void _handleError({required String responseBody, required int statusCode}) {
    throw UnexpectedException(errorCode: statusCode);
  }
}
