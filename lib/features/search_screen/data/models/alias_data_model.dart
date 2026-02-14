import '../../domain/entities/alias_data.dart';

class AliasDataModel extends AliasData {
  const AliasDataModel({required super.termId, required super.termName});

  factory AliasDataModel.fromJson(Map<String, dynamic> json) {
    return AliasDataModel(
      termId: json['term_id'] as int? ?? 0,
      termName: json['term_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'term_id': termId, 'term_name': termName};
  }
}
