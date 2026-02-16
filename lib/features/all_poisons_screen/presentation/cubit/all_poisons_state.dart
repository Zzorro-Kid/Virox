import 'package:equatable/equatable.dart';
import '../../../search_screen/domain/entities/poison_data.dart';

sealed class AllPoisonsState extends Equatable {
  const AllPoisonsState();

  @override
  List<Object?> get props => [];
}

class AllPoisonsInitial extends AllPoisonsState {}

class AllPoisonsLoading extends AllPoisonsState {}

class AllPoisonsLoaded extends AllPoisonsState {
  final List<PoisonData> poisons;

  const AllPoisonsLoaded({required this.poisons});

  @override
  List<Object?> get props => [poisons];
}

class AllPoisonsError extends AllPoisonsState {
  final String message;

  const AllPoisonsError(this.message);

  @override
  List<Object?> get props => [message];
}
