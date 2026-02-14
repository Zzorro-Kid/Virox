import 'package:equatable/equatable.dart';
import 'first_aid_type_data.dart';

class FirstAidContentData extends Equatable {
  final FirstAidTypeData category;
  final String title;
  final String videoUrl;
  final String videoThumbnail;
  final String description;
  final List<String> instructions;
  final String importantNote;

  const FirstAidContentData({
    required this.category,
    required this.title,
    required this.videoUrl,
    required this.videoThumbnail,
    required this.description,
    required this.instructions,
    required this.importantNote,
  });

  @override
  List<Object?> get props => [
    category,
    title,
    videoUrl,
    videoThumbnail,
    description,
    instructions,
    importantNote,
  ];
}