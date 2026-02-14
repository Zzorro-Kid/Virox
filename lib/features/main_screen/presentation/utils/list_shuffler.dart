import '../../../home/domain/entities/poison_data.dart';

class ListShuffler {
  List<PoisonData> getShuffledList(List<PoisonData> list) {
    final shuffledList = list..shuffle();
    return shuffledList;
  }
}
