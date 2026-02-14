import 'package:equatable/equatable.dart';

import 'alias_data.dart';
import 'risk_level_data.dart';

class PoisonData extends Equatable {
  final int id;
  final String name;
  final List<AliasData> aliases;
  final RiskLevel riskLevel;
  final String imageUrl;
  final String symptoms;
  final String whatToDo;
  final String importantNote;
  final String additionalInfo;
  final String shareUrl;

  const PoisonData({
    required this.id,
    required this.name,
    required this.aliases,
    required this.riskLevel,
    required this.imageUrl,
    required this.symptoms,
    required this.whatToDo,
    required this.importantNote,
    required this.additionalInfo,
    required this.shareUrl,
  });

  const PoisonData.empty()
    : id = 0,
      name = '',
      aliases = const <AliasData>[],
      riskLevel = RiskLevel.lowRisk,
      imageUrl = '',
      symptoms = '',
      whatToDo = '',
      importantNote = '',
      additionalInfo = '',
      shareUrl = '';

  @override
  List<Object?> get props => [
    id,
    name,
    aliases,
    riskLevel,
    imageUrl,
    symptoms,
    whatToDo,
    importantNote,
    additionalInfo,
    shareUrl,
  ];
}
