import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/network/network_info.dart';
import 'package:virox/features/search_screen/data/models/poison_list_data_model.dart';
import 'package:virox/features/search_screen/data/repositories/poison_repository_impl.dart';
import 'package:virox/features/search_screen/data/sources/local/poisons_local_data_source.dart';
import 'package:virox/features/search_screen/data/sources/remote/poisons_remote_data_source.dart';

class MockPoisonRemoteDataSource extends Mock
    implements PoisonRemoteDataSource {}

class MockPoisonLocalDataSource extends Mock implements PoisonLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockPoisonRemoteDataSource mockRemoteDataSource;
  late MockPoisonLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late PoisonRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockPoisonRemoteDataSource();
    mockLocalDataSource = MockPoisonLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PoisonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getAllPoisons', () {
    const tPoisonListModel = PoisonListDataModel(poisons: []);

    test('should call remoteDataSource.getPoisons when online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.getPoisons(),
      ).thenAnswer((_) async => tPoisonListModel);
      // act
      await repository.getAllPoisons();
      //assert
      verify(() => mockNetworkInfo.isConnected);
      verify(() => mockRemoteDataSource.getPoisons());
    });

    test('should call localDataSource.getPoisons when offline', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocalDataSource.getPoisons(),
      ).thenAnswer((_) async => tPoisonListModel);
      // act
      await repository.getAllPoisons();
      // assert
      verify(() => mockNetworkInfo.isConnected);
      verify(() => mockLocalDataSource.getPoisons());
    });
  });
}
