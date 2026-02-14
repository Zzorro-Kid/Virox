import 'dart:convert';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/data/sources/base_remote_data_source.dart';
import '../../../../../core/shared_prefs.dart';
import '../../models/poison_list_data_model.dart';
import '../../models/version_data_model.dart';

abstract class PoisonRemoteDataSource {
  Future<PoisonListDataModel> getPoisons();
}

class PoisonRemoteDataSourceImpl extends BaseRemoteDataSource
    implements PoisonRemoteDataSource {
  final SharedPrefs sharedPref;

  const PoisonRemoteDataSourceImpl({
    required super.client,
    required this.sharedPref,
  });

  @override
  Future<PoisonListDataModel> getPoisons() async {
    final serverVersion = await _getVersion();
    if (serverVersion.version == sharedPref.version) {
      final cachedData = sharedPref.poisonData;
      if (cachedData.isNotEmpty) {
        final jsonList = jsonDecode(cachedData) as List<dynamic>;
        return PoisonListDataModel.fromJson(jsonList);
      }
    }
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.poisonsEndpoint}'),
    );
    final jsonList = handleListResponse(response);
    final model = PoisonListDataModel.fromJson(jsonList);

    await sharedPref.setPoisonData(response.body);
    await sharedPref.setVersion(serverVersion.version);

    return model;
  }

  Future<VersionDataModel> _getVersion() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.versionEndpoint}'),
    );
    final json = handleObjectResponse(response);
    return VersionDataModel.fromJson(json);
  }
}
