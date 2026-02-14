import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/poison_data.dart';

sealed class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object?> get props => [];
}

class MainScreenInitial extends MainScreenState {
  const MainScreenInitial();
}

class MainScreenLoading extends MainScreenState {
  const MainScreenLoading();
}

class MainScreenLoaded extends MainScreenState {
  final List<PoisonData> poisons;

  const MainScreenLoaded({required this.poisons});

  @override
  List<Object?> get props => [poisons];
}

class MainScreenError extends MainScreenState {
  final String message;

  const MainScreenError(this.message);

  @override
  List<Object?> get props => [message];
}