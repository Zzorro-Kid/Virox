import '../../domain/entities/alias_data.dart';
import '../../domain/entities/poison_data.dart';
import '../../domain/entities/risk_level_data.dart';
import 'alias_data_model.dart';

class PoisonDataModel extends PoisonData {
  const PoisonDataModel({
    required super.id,
    required super.name,
    required super.aliases,
    required super.riskLevel,
    required super.imageUrl,
    required super.symptoms,
    required super.whatToDo,
    required super.importantNote,
    required super.additionalInfo,
    required super.shareUrl,
  });

  factory PoisonDataModel.fromJson(Map<String, dynamic> json) {
    return PoisonDataModel(
      id: _parseId(json['id']),
      name: _parseName(json['poison_name']),
      aliases: _parseAliases(json['also_known_as']),
      riskLevel: _parseRiskLevel(json['poison_risk']),
      imageUrl: _parseImageUrl(json['poison_thumbnail']),
      symptoms: _parseSymptoms(json['possible_symptoms']),
      whatToDo: _parseWhatToDo(json['what_to_do']),
      importantNote: _parseImportantNote(json['important_notice']),
      additionalInfo: _parseAdditionalInfo(json['additional_information']),
      shareUrl: _parseShareUrl(json['share_url']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _serializeId(id),
      'poison_name': name,
      'poison_risk': _serializeRiskLevel(riskLevel),
      'poison_thumbnail': imageUrl,
      'also_known_as': _serializeAliases(aliases),
      'possible_symptoms': symptoms,
      'what_to_do': whatToDo,
      'important_notice': importantNote,
      'additional_information': additionalInfo,
      'share_url': shareUrl,
    };
  }

  static int _parseId(dynamic id) {
    if (id == null) {
      return 0;
    }
    return id as int? ?? 0;
  }

  static String _parseName(dynamic name) {
    return name as String? ?? '';
  }

  static List<AliasDataModel> _parseAliases(dynamic aliases) {
    if (aliases == null) {
      return [];
    }

    final dynamicAliasList = aliases as List<dynamic>? ?? [];
    if (dynamicAliasList.isEmpty) {
      return [];
    }

    final List<AliasDataModel> aliasDataModelList = dynamicAliasList
        .whereType<Map<String, dynamic>>()
        .map(AliasDataModel.fromJson)
        .toList();

    return aliasDataModelList;
  }

  static RiskLevel _parseRiskLevel(dynamic risk) {
    final riskString = risk as String? ?? '';
    if (riskString.isEmpty) {
      return RiskLevel.unknown;
    }

    return RiskLevel.values.firstWhere((level) {
      return level.name == riskString;
    }, orElse: () => RiskLevel.unknown);
  }

  static String _parseImageUrl(dynamic imageUrl) {
    return imageUrl as String? ?? '';
  }

  static String _parseSymptoms(dynamic symptoms) {
    return symptoms as String? ?? '';
  }

  static String _parseWhatToDo(dynamic whatToDo) {
    return whatToDo as String? ?? '';
  }

  static String _parseImportantNote(dynamic importantNote) {
    return importantNote as String? ?? '';
  }

  static String _parseAdditionalInfo(dynamic additionalInfo) {
    return additionalInfo as String? ?? '';
  }

  static String _parseShareUrl(dynamic shareUrl) {
    return shareUrl as String? ?? '';
  }

  static int _serializeId(int id) {
    return id;
  }

  static String _serializeRiskLevel(RiskLevel riskLevel) {
    return riskLevel.name;
  }

  static List<Map<String, dynamic>> _serializeAliases(List<AliasData> aliases) {
    return aliases
        .whereType<AliasDataModel>()
        .map((alias) => alias.toJson())
        .toList();
  }
}
