import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_screen/presentation/utils/list_shuffler.dart';
import '../../../search_screen/domain/entities/poison_data.dart';
import '../../../search_screen/domain/repositories/poison_repository.dart';
import 'all_poisons_state.dart';

class AllPoisonsCubit extends Cubit<AllPoisonsState> {
  final PoisonRepository repository;
  final ListShuffler listShuffler;

  List<PoisonData> _cachedPoisons = [];

  AllPoisonsCubit({required this.repository, required this.listShuffler})
    : super(AllPoisonsInitial()) {
    loadPoisons();
  }

  Future<void> loadPoisons() async {
    emit(AllPoisonsLoading());

    final result = await repository.getAllPoisons();

    result.fold((failure) => emit(AllPoisonsError(failure.message)), (
      poisonListData,
    ) {
      _cachedPoisons = listShuffler.getShuffledList(poisonListData.poisons);
      emit(AllPoisonsLoaded(poisons: _cachedPoisons));
    });
  }

  void searchPoisons(String query) {
    if (query.isEmpty) {
      emit(AllPoisonsLoaded(poisons: _cachedPoisons));
    } else {
      final filtered = _findMatchingPoisons(query, _cachedPoisons);
      emit(AllPoisonsLoaded(poisons: filtered));
    }
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
}
