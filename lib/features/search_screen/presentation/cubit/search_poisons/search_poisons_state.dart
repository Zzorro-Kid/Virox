import 'package:equatable/equatable.dart';
import '../../../domain/entities/poison_data.dart';

sealed class SearchPoisonsState extends Equatable {
  const SearchPoisonsState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchPoisonsState {
  final List<String> searchHistory;

  const SearchInitial({this.searchHistory = const []});

  @override
  List<Object?> get props => [searchHistory];
}

class SearchLoading extends SearchPoisonsState {
  const SearchLoading();
}

class SearchLoaded extends SearchPoisonsState {
  final List<PoisonData> results;
  final String query;

  const SearchLoaded({required this.results, required this.query});

  @override
  List<Object?> get props => [results, query];
}

class SearchError extends SearchPoisonsState {
  final String query;

  const SearchError(this.query);

  @override
  List<Object?> get props => [query];
}
