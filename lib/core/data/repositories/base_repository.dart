import 'package:dartz/dartz.dart';

import '../../error/failures.dart';
import '../../network/network_info.dart';

class BaseRepository {
  final NetworkInfo networkInfo;

  BaseRepository(this.networkInfo);

  Future<Either<Failure, T>> checkNetworkAndDoRequest<T>({
    required Future<T> Function() remoteRequest,
    Future<T> Function()? localRequest,
  }) async {
    if (await networkInfo.isConnected) {
      return _executeRemoteRequest(remoteRequest, localRequest);
    } else {
      return _executeLocalRequest(localRequest);
    }
  }

  Future<Either<Failure, T>> _executeRemoteRequest<T>(
    Future<T> Function() remoteRequest,
    Future<T> Function()? localRequest,
  ) async {
    try {
      final result = await remoteRequest();
      return Right(result);
    } catch (e) {
      if (localRequest != null) {
        return _executeLocalRequest(localRequest);
      }
      return Left(UnexpectedFailure(message: e.runtimeType.toString()));
    }
  }

  Future<Either<Failure, T>> _executeLocalRequest<T>(
    Future<T> Function()? localRequest,
  ) async {
    try {
      final result = await localRequest?.call();
      if (result != null) {
        return Right(result);
      }
      return const Left(NoLocalDataRequestFailure());
    } catch (e) {
      return Left(UnexpectedFailure(message: e.runtimeType.toString()));
    }
  }
}
