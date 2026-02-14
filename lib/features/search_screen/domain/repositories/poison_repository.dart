import 'package:dartz/dartz.dart';

import '../../../../core/data/repositories/base_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/poison_list_data.dart';

abstract class PoisonRepository extends BaseRepository {
  PoisonRepository(super.networkInfo);

  Future<Either<Failure, PoisonListData>> getAllPoisons();
}
