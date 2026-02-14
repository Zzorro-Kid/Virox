import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/data/repositories/base_repository.dart';
import 'package:virox/core/error/exceptions.dart';
import 'package:virox/core/error/failures.dart';
import 'package:virox/core/network/network_info.dart';
import 'package:virox/features/home/data/models/poison_list_data_model.dart';
import 'package:virox/features/home/data/sources/remote/poisons_remote_data_source.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockPoisonRemoteDataSource extends Mock
    implements PoisonRemoteDataSource {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockPoisonRemoteDataSource mockRemoteDataSource;
  late BaseRepository repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockPoisonRemoteDataSource();
    repository = BaseRepository(mockNetworkInfo);
  });

  group('checkNetworkAndDoRequest', () {
    const tPoisonListModel = PoisonListDataModel(poisons: []);

    test('should call remoteRequest when network is available and return Right '
        'when remoteRequest succeeds', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.getPoisons(),
      ).thenAnswer((_) async => tPoisonListModel);
      // act
      final result = await repository.checkNetworkAndDoRequest(
        remoteRequest: () => mockRemoteDataSource.getPoisons(),
      );
      // assert
      expect(result, const Right(tPoisonListModel));
      verify(() => mockNetworkInfo.isConnected);
      verify(() => mockRemoteDataSource.getPoisons());
    });

    test('should return Left with UnexpectedFailure when remoteRequest throws '
        'Exception and localRequest is null', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = await repository.checkNetworkAndDoRequest(
        remoteRequest: () =>
            throw UnexpectedException(errorCode: 1, message: 'error'),
      );
      // assert
      expect(
        result,
        const Left(UnexpectedFailure(message: 'UnexpectedException')),
      );
      verify(() => mockNetworkInfo.isConnected);
    });

    test('should call localRequest when remoteRequest throws Exception '
        'and localRequest is provided', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      bool isLocalRequestCalled = false;
      final result = await repository.checkNetworkAndDoRequest(
        remoteRequest: () =>
            throw UnexpectedException(errorCode: 1, message: 'error'),
        localRequest: () async {
          isLocalRequestCalled = true;
          return tPoisonListModel;
        },
      );
      // assert
      expect(result, const Right(tPoisonListModel));
      expect(isLocalRequestCalled, true);
      verify(() => mockNetworkInfo.isConnected);
    });

    test('should call localRequest when network is not available', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockRemoteDataSource.getPoisons(),
      ).thenAnswer((_) async => tPoisonListModel);
      // act
      bool isLocalRequestCalled = false;
      await repository.checkNetworkAndDoRequest(
        remoteRequest: () => mockRemoteDataSource.getPoisons(),
        localRequest: () async {
          isLocalRequestCalled = true;
        },
      );
      // assert
      expect(isLocalRequestCalled, true);
      verify(() => mockNetworkInfo.isConnected);
      verifyNever(() => mockRemoteDataSource.getPoisons());
    });

    test('should return Right with data when localRequest succeeds', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      bool isLocalRequestCalled = false;
      final result = await repository.checkNetworkAndDoRequest(
        remoteRequest: () => mockRemoteDataSource.getPoisons(),
        localRequest: () async {
          isLocalRequestCalled = true;

          return '';
        },
      );
      // assert
      expect(result, const Right(''));
      expect(isLocalRequestCalled, true);
      verify(() => mockNetworkInfo.isConnected);
      verifyNever(() => mockRemoteDataSource.getPoisons());
    });

    test(
      'should return Left with NoLocalDataFailure when localRequest is null',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repository.checkNetworkAndDoRequest(
          remoteRequest: () async => mockRemoteDataSource.getPoisons(),
        );
        // assert
        expect(result, const Left(NoLocalDataRequestFailure()));
        verify(() => mockNetworkInfo.isConnected);
        verifyNever(() => mockRemoteDataSource.getPoisons());
      },
    );

    test(
      'should return Left with UnexpectedFailure when localRequest throws Exception',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repository.checkNetworkAndDoRequest(
          remoteRequest: () async => mockRemoteDataSource.getPoisons(),
          localRequest: () =>
              throw UnexpectedException(errorCode: 1, message: 'error'),
        );
        // assert
        expect(
          result,
          const Left(UnexpectedFailure(message: 'UnexpectedException')),
        );
        verify(() => mockNetworkInfo.isConnected);
        verifyNever(() => mockRemoteDataSource.getPoisons());
      },
    );
  });
}
