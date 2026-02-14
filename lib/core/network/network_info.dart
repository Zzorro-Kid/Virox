import 'dart:developer';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    const uriString = '${ApiConstants.baseUrl}${ApiConstants.versionEndpoint}';

    try {
      final response = await http
          .head(Uri.parse(uriString))
          .timeout(ApiConstants.connectivityCheckTimeout);

      if (response.statusCode >= 100 && response.statusCode < 600) {
        return true;
      }

      return false;
    } catch (e) {
      log('Error checking internet connection: $e');
      return false;
    }
  }
}
