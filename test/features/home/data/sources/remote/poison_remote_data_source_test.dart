import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/constants/api_constants.dart';
import 'package:virox/core/shared_prefs.dart';
import 'package:virox/features/search_screen/data/models/poison_data_model.dart';
import 'package:virox/features/search_screen/data/models/poison_list_data_model.dart';
import 'package:virox/features/search_screen/data/sources/remote/poisons_remote_data_source.dart';
import 'package:virox/features/search_screen/domain/entities/risk_level_data.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockSharedPrefs extends Mock implements SharedPrefs {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockSharedPrefs mockSharedPrefs;
  late PoisonRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    mockSharedPrefs = MockSharedPrefs();
    dataSource = PoisonRemoteDataSourceImpl(
      client: mockHttpClient,
      sharedPref: mockSharedPrefs,
    );
  });

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  group('getPoisons', () {
    const tPoisonDataModel = PoisonDataModel(
      id: 35204,
      name: 'Shower Steamers',
      aliases: [],
      riskLevel: RiskLevel.lowRisk,
      imageUrl: 'https://example.com/image.webp',
      symptoms: '<p>Test symptoms</p>',
      whatToDo: '<p>Test instructions</p>',
      importantNote: '',
      additionalInfo: '',
      shareUrl: '',
    );
    const tPoisonListModel = PoisonListDataModel(poisons: [tPoisonDataModel]);
    final tPoisonsUri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.poisonsEndpoint}',
    );
    final tVersionUri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.versionEndpoint}',
    );
    const tResponseBody = '''
[
  {
    "id": 35204,
    "poison_name": "Shower Steamers",
    "poison_risk": "Low Risk",
    "poison_thumbnail": "https://example.com/image.webp",
    "also_known_as": [],
    "possible_symptoms": "<p>Test symptoms</p>",
    "what_to_do": "<p>Test instructions</p>",
    "important_notice": "",
    "additional_information": "",
    "share_url": ""
  }
]
''';
    const tServerVersion = 2;

    setUp(() {
      when(() => mockHttpClient.get(tVersionUri)).thenAnswer(
        (_) async => http.Response('{"version": $tServerVersion}', 200),
      );
      when(
        () => mockHttpClient.get(tPoisonsUri),
      ).thenAnswer((_) async => http.Response(tResponseBody, 200));
      when(
        () => mockSharedPrefs.setPoisonData(tResponseBody),
      ).thenAnswer((_) async => true);
      when(
        () => mockSharedPrefs.setVersion(tServerVersion),
      ).thenAnswer((_) async => true);
    });

    test('returns cached data when versions match and cache exists', () async {
      when(() => mockSharedPrefs.version).thenReturn(2);
      when(() => mockSharedPrefs.poisonData).thenReturn(tResponseBody);

      final result = await dataSource.getPoisons();

      verify(() => mockHttpClient.get(tVersionUri));
      verify(() => mockSharedPrefs.version);
      verify(() => mockSharedPrefs.poisonData);
      expect(result, tPoisonListModel);
    });

    test(
      'fetches from server when versions match but cache is empty',
      () async {
        when(() => mockSharedPrefs.version).thenReturn(2);
        when(() => mockSharedPrefs.poisonData).thenReturn('');

        final result = await dataSource.getPoisons();

        verify(() => mockHttpClient.get(tVersionUri));
        verify(() => mockSharedPrefs.version);
        verify(() => mockSharedPrefs.poisonData);
        verify(() => mockHttpClient.get(tPoisonsUri));
        verify(() => mockSharedPrefs.setPoisonData(tResponseBody));
        verify(() => mockSharedPrefs.setVersion(tServerVersion));
        expect(result, tPoisonListModel);
      },
    );

    test('fetches from server when versions do not match', () async {
      when(() => mockSharedPrefs.version).thenReturn(1);

      final result = await dataSource.getPoisons();

      verify(() => mockHttpClient.get(tVersionUri));
      verify(() => mockSharedPrefs.version);
      verify(() => mockHttpClient.get(tPoisonsUri));
      verify(() => mockSharedPrefs.setPoisonData(tResponseBody));
      verify(() => mockSharedPrefs.setVersion(tServerVersion));
      expect(result, tPoisonListModel);
    });
  });
}
