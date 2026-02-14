import '../../domain/entities/version_data.dart';

class VersionDataModel extends VersionData {
  const VersionDataModel({required super.version});

  factory VersionDataModel.fromJson(Map<String, dynamic> json) {
    return VersionDataModel(version: json['version'] as int? ?? -1);
  }

  Map<String, dynamic> toJson() {
    return {'version': version};
  }
}
