import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search_screen/domain/repositories/poison_repository.dart';
import '../utils/list_shuffler.dart';
import 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  final PoisonRepository repository;
  final ListShuffler listShuffler;

  MainScreenCubit({required this.repository, required this.listShuffler})
    : super(const MainScreenInitial());

  Future<void> loadAllPoisons() async {
    emit(const MainScreenLoading());

    final result = await repository.getAllPoisons();

    result.fold(
      (failure) => emit(const MainScreenError('Failed to load data')),
      (poisonListData) {
        final poisons = listShuffler.getShuffledList(poisonListData.poisons);
        emit(MainScreenLoaded(poisons: poisons));
      },
    );
  }
}
