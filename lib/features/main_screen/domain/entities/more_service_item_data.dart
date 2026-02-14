import 'package:equatable/equatable.dart';

class MoreServiceItemData extends Equatable {
  final String title;
  final String iconPath;
  final String url;

  const MoreServiceItemData({
    required this.title,
    required this.iconPath,
    required this.url,
  });

  @override
  List<Object?> get props => [title, iconPath, url];
}