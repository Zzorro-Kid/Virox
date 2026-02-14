import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared_prefs.dart';
import '../../../domain/entities/poison_data.dart';
import '../../../domain/repositories/poison_repository.dart';
import '../../utils/search_history_manager.dart';
import 'search_poisons_state.dart';

class SearchPoisonsCubit extends Cubit<SearchPoisonsState> {
  final PoisonRepository repository;
  final SharedPrefs sharedPrefs;
  final SearchHistoryManager searchHistoryManager;

  SearchPoisonsCubit({
    required this.repository,
    required this.sharedPrefs,
    required this.searchHistoryManager,
  }) : super(const SearchInitial());

  void onTextInput(String query) {
    if (query.isEmpty) {
      emit(SearchInitial(searchHistory: sharedPrefs.searchHistory));
      return;
    }
    _runSearch(query);
  }

  Future<void> onSearchSubmit(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial(searchHistory: sharedPrefs.searchHistory));
      return;
    }

    await _runSearch(query);
    await searchHistoryManager.addToHistory(query);
  }

  void resetSearch() {
    emit(SearchInitial(searchHistory: sharedPrefs.searchHistory));
  }

  Future<void> loadSearchHistory() async {
    final history = sharedPrefs.searchHistory;
    if (history.isNotEmpty) {
      emit(SearchInitial(searchHistory: history));
    }
  }

  Future<void> _runSearch(String query) async {
    emit(const SearchLoading());

    final result = await repository.getAllPoisons();
    result.fold((failure) => emit(const SearchError('Failed to load data')), (
      poisons,
    ) {
      final filteredResults = _findMatchingPoisons(query, poisons.poisons);
      _emitResult(query, filteredResults);
    });
  }

  List<PoisonData> _findMatchingPoisons(
    String query,
    List<PoisonData> poisons,
  ) {
    final queryLowerCase = query.toLowerCase();

    return poisons.where((poison) {
      final poisonAliases = poison.aliases;
      final isAliasFound = poisonAliases.any(
        (alias) => alias.termName.toLowerCase().contains(queryLowerCase),
      );
      if (!isAliasFound) {
        return poison.name.toLowerCase().contains(queryLowerCase);
      }

      return true;
    }).toList();
  }

  void _emitResult(String query, List<PoisonData> results) {
    if (results.isEmpty) {
      emit(SearchError(query));
    } else {
      emit(SearchLoaded(results: results, query: query));
    }
  }
}
