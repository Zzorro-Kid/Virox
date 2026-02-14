import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/shared_prefs.dart';
import '../../models/poison_list_data_model.dart';

abstract class PoisonLocalDataSource {
  Future<PoisonListDataModel> getPoisons();
}

class PoisonLocalDataSourceImpl implements PoisonLocalDataSource {
  final SharedPrefs sharedPref;

  PoisonLocalDataSourceImpl({required this.sharedPref});

  @override
  Future<PoisonListDataModel> getPoisons() async {
    try {
      final cachedData = sharedPref.poisonData;
      final jsonString = cachedData.isNotEmpty
          ? cachedData
          : await rootBundle.loadString(ApiConstants.assetsPostsPath);

      final jsonList = json.decode(jsonString) as List<dynamic>;
      return PoisonListDataModel.fromJson(jsonList);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached data: $e');
    }
  }
}
