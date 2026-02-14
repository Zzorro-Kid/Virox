import '../../domain/entities/poison_list_data.dart';
import 'poison_data_model.dart';

class PoisonListDataModel extends PoisonListData {
  const PoisonListDataModel({required super.poisons});

  factory PoisonListDataModel.fromJson(List<dynamic> json) {
    if (json.isEmpty) {
      return const PoisonListDataModel(poisons: []);
    }

    final poisons = json
        .map(
          (poison) => PoisonDataModel.fromJson(poison as Map<String, dynamic>),
        )
        .toList();

    return PoisonListDataModel(poisons: poisons);
  }

  List<Map<String, dynamic>> toJson() {
    return poisons
        .whereType<PoisonDataModel>()
        .map((poison) => poison.toJson())
        .toList();
  }
}
