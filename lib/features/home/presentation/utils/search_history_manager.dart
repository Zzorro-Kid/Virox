import '../../../../core/shared_prefs.dart';

class SearchHistoryManager {
  static const int maxHistoryItems = 10;
  final SharedPrefs _sharedPrefs;

  SearchHistoryManager({required SharedPrefs sharedPrefs})
    : _sharedPrefs = sharedPrefs;

  Future<void> addToHistory(String query) async {
    if (query.isEmpty) {
      return;
    }

    final history = List<String>.from(_sharedPrefs.searchHistory)
      ..remove(query)
      ..insert(0, query);

    if (history.length > maxHistoryItems) {
      history.removeRange(maxHistoryItems, history.length);
    }

    await _sharedPrefs.setSearchHistory(history);
  }
}
