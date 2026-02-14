import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _poisonDataKey = 'poisonData';
  static const _searchHistoryKey = 'searchHistory';
  static const _versionKey = 'version';

  final SharedPreferences _sharedPreferences;

  SharedPrefs(this._sharedPreferences);

  Future<bool> setPoisonData(String poisonData) async {
    return _sharedPreferences.setString(_poisonDataKey, poisonData);
  }

  String get poisonData {
    return _sharedPreferences.getString(_poisonDataKey) ?? '';
  }

  Future<bool> setSearchHistory(List<String> history) async {
    return _sharedPreferences.setStringList(_searchHistoryKey, history);
  }

  List<String> get searchHistory {
    return _sharedPreferences.getStringList(_searchHistoryKey) ?? [];
  }

  Future<bool> setVersion(int version) async {
    return _sharedPreferences.setInt(_versionKey, version);
  }

  int get version {
    return _sharedPreferences.getInt(_versionKey) ?? 0;
  }
}
