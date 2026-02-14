import 'package:equatable/equatable.dart';
import 'poison_data.dart';

class PoisonListData extends Equatable {
  final List<PoisonData> poisons;

  const PoisonListData({required this.poisons});

  const PoisonListData.empty() : poisons = const <PoisonData>[];

  @override
  List<Object?> get props => [poisons];
}
