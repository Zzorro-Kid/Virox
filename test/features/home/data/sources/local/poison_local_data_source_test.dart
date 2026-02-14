import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/error/exceptions.dart';
import 'package:virox/core/shared_prefs.dart';
import 'package:virox/features/home/data/models/poison_list_data_model.dart';
import 'package:virox/features/home/data/sources/local/poisons_local_data_source.dart';

class MockSharedPrefs extends Mock implements SharedPrefs {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSharedPrefs mockSharedPrefs;
  late PoisonLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPrefs = MockSharedPrefs();
    dataSource = PoisonLocalDataSourceImpl(sharedPref: mockSharedPrefs);
  });

  group('getPoisons', () {
    const tPoisonListModel = PoisonListDataModel(poisons: []);
    const tCachedData = '[]';

    test(
      'should return PoisonListDataModel from cache if cache is not empty',
      () async {
        // arrange
        when(() => mockSharedPrefs.poisonData).thenReturn(tCachedData);
        // act
        final result = await dataSource.getPoisons();
        // assert
        verify(() => mockSharedPrefs.poisonData);
        expect(result, tPoisonListModel);
      },
    );

    test('should load from assets if cache is empty', () async {
      // arrange
      const tAssetData = '''
[
        {
          "id": 1,
          "poison_name": "Test Poison",
          "poison_risk": "high",
          "poison_thumbnail": "https://example.com/test.jpg",
          "also_known_as": [
            {"term_id": 1, "term_name": "Test Alias"}
          ],
          "possible_symptoms": "Test symptoms",
          "what_to_do": "Test what to do",
          "important_notice": "Test notice",
          "additional_information": "Test info",
          "share_url": "https://example.com/share"
        }
      ]''';
      when(() => mockSharedPrefs.poisonData).thenReturn('');

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
            return ByteData.view(
              Uint8List.fromList(utf8.encode(tAssetData)).buffer,
            );
          });

      // act
      final result = await dataSource.getPoisons();

      // assert
      expect(result, isA<PoisonListDataModel>());
    });

    test('should throw CacheException if json decode fails', () async {
      // arrange
      when(() => mockSharedPrefs.poisonData).thenReturn('invalid json');
      // act
      final call = dataSource.getPoisons;
      // assert
      expect(call, throwsA(isA<CacheException>()));
    });
  });
}
