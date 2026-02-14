import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/poison_list_data.dart';
import '../../domain/repositories/poison_repository.dart';
import '../sources/local/poisons_local_data_source.dart';
import '../sources/remote/poisons_remote_data_source.dart';

class PoisonRepositoryImpl extends PoisonRepository {
  final PoisonRemoteDataSource remoteDataSource;
  final PoisonLocalDataSource localDataSource;

  PoisonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required NetworkInfo networkInfo,
  }) : super(networkInfo);

  @override
  Future<Either<Failure, PoisonListData>> getAllPoisons() async {
    return checkNetworkAndDoRequest<PoisonListData>(
      remoteRequest: remoteDataSource.getPoisons,
      localRequest: localDataSource.getPoisons,
    );
  }
}
