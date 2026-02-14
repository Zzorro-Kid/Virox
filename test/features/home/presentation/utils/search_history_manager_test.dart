import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/shared_prefs.dart';
import 'package:virox/features/search_screen/presentation/utils/search_history_manager.dart';

class MockSharedPrefs extends Mock implements SharedPrefs {}

void main() {
  late MockSharedPrefs mockSharedPrefs;
  late SearchHistoryManager historyManager;

  setUp(() {
    mockSharedPrefs = MockSharedPrefs();
    historyManager = SearchHistoryManager(sharedPrefs: mockSharedPrefs);
  });

  setUpAll(() {
    registerFallbackValue('');
  });

  group('addToHistory', () {
    test('does not add empty query to history', () async {
      when(() => mockSharedPrefs.searchHistory).thenReturn(['item1']);

      await historyManager.addToHistory('');

      verifyNever(() => mockSharedPrefs.setSearchHistory(any()));
    });

    test('adds new query to the beginning of history', () async {
      when(() => mockSharedPrefs.searchHistory).thenReturn(['old1', 'old2']);
      when(
        () => mockSharedPrefs.setSearchHistory(any()),
      ).thenAnswer((_) async => true);

      await historyManager.addToHistory('new');

      verify(
        () => mockSharedPrefs.setSearchHistory(['new', 'old1', 'old2']),
      ).called(1);
    });

    test('removes duplicate and adds query to the beginning', () async {
      when(
        () => mockSharedPrefs.searchHistory,
      ).thenReturn(['item1', 'item2', 'item3']);
      when(
        () => mockSharedPrefs.setSearchHistory(any()),
      ).thenAnswer((_) async => true);

      await historyManager.addToHistory('item2');

      verify(
        () => mockSharedPrefs.setSearchHistory(['item2', 'item1', 'item3']),
      ).called(1);
    });

    test('limits history to maximum 10 items', () async {
      when(() => mockSharedPrefs.searchHistory).thenReturn([
        'item1',
        'item2',
        'item3',
        'item4',
        'item5',
        'item6',
        'item7',
        'item8',
        'item9',
        'item10',
      ]);
      when(
        () => mockSharedPrefs.setSearchHistory(any()),
      ).thenAnswer((_) async => true);

      await historyManager.addToHistory('new');

      verify(
        () => mockSharedPrefs.setSearchHistory([
          'new',
          'item1',
          'item2',
          'item3',
          'item4',
          'item5',
          'item6',
          'item7',
          'item8',
          'item9',
        ]),
      ).called(1);
    });
  });
}
