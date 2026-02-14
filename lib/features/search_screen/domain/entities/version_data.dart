import 'package:equatable/equatable.dart';

class VersionData extends Equatable {
  final int version;

  const VersionData({required this.version});

  @override
  List<Object?> get props => [version];
}
