import 'package:equatable/equatable.dart';

class AliasData extends Equatable {
  final int termId;
  final String termName;

  const AliasData({required this.termId, required this.termName});

  @override
  List<Object?> get props => [termId, termName];
}
