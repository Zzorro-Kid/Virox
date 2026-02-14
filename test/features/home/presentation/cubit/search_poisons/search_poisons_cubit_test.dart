import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/error/failures.dart';
import 'package:virox/core/shared_prefs.dart';
import 'package:virox/features/home/data/models/poison_list_data_model.dart';
import 'package:virox/features/home/domain/entities/alias_data.dart';
import 'package:virox/features/home/domain/entities/poison_data.dart';
import 'package:virox/features/home/domain/entities/risk_level_data.dart';
import 'package:virox/features/home/domain/repositories/poison_repository.dart';
import 'package:virox/features/home/presentation/cubit/search_poisons/search_poisons_cubit.dart';
import 'package:virox/features/home/presentation/cubit/search_poisons/search_poisons_state.dart';
import 'package:virox/features/home/presentation/utils/search_history_manager.dart';

class MockPoisonRepository extends Mock implements PoisonRepository {}

class MockSharedPrefs extends Mock implements SharedPrefs {}

class MockSearchHistoryManager extends Mock implements SearchHistoryManager {}

void main() {
  late MockPoisonRepository mockRepository;
  late MockSharedPrefs mockSharedPrefs;
  late MockSearchHistoryManager mockSearchHistoryManager;
  late SearchPoisonsCubit cubit;

  final tPoisons = [
    const PoisonData(
      id: 1,
      name: '',
      aliases: [],
      riskLevel: RiskLevel.unknown,
      imageUrl: '',
      symptoms: '',
      whatToDo: '',
      importantNote: '',
      additionalInfo: '',
      shareUrl: '',
    ),
    const PoisonData(
      id: -1,
      name: 'Aspirin',
      aliases: [],
      riskLevel: RiskLevel.unknown,
      imageUrl: '',
      symptoms: '',
      whatToDo: '',
      importantNote: '',
      additionalInfo: '',
      shareUrl: '',
    ),
    const PoisonData(
      id: -2,
      name: '',
      aliases: [AliasData(termId: 1, termName: 'Acetaminophen')],
      riskLevel: RiskLevel.unknown,
      imageUrl: '',
      symptoms: '',
      whatToDo: '',
      importantNote: '',
      additionalInfo: '',
      shareUrl: '',
    ),
  ];

  setUp(() {
    mockRepository = MockPoisonRepository();
    mockSharedPrefs = MockSharedPrefs();
    mockSearchHistoryManager = MockSearchHistoryManager();
    cubit = SearchPoisonsCubit(
      repository: mockRepository,
      sharedPrefs: mockSharedPrefs,
      searchHistoryManager: mockSearchHistoryManager,
    );
  });

  setUpAll(() {
    registerFallbackValue('');
  });

  group('SearchPoisonsCubit initial state', () {
    test('initial state is SearchInitial', () {
      expect(cubit.state, equals(const SearchInitial()));
    });
  });

  group('onTextInput', () {
    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchInitial with history when query is empty',
      setUp: () {
        when(
          () => mockSharedPrefs.searchHistory,
        ).thenReturn(['test1', 'test2']);
      },
      build: () => cubit,
      act: (cubit) => cubit.onTextInput(''),
      expect: () => [
        const SearchInitial(searchHistory: ['test1', 'test2']),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchLoading then SearchLoaded when searching by name',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => Right(PoisonListDataModel(poisons: tPoisons)),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.onTextInput('aspirin'),
      expect: () => [
        const SearchLoading(),
        SearchLoaded(results: [tPoisons[1]], query: 'aspirin'),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchLoading then SearchLoaded when searching by alias',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => Right(PoisonListDataModel(poisons: tPoisons)),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.onTextInput('acetaminophen'),
      expect: () => [
        const SearchLoading(),
        SearchLoaded(results: [tPoisons[2]], query: 'acetaminophen'),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchError when no results found',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => const Right(PoisonListDataModel(poisons: [])),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.onTextInput('No results found, try again'),
      expect: () => [
        const SearchLoading(),
        const SearchError('No results found, try again'),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchError when repository fails',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => const Left(UnexpectedFailure(message: 'Failed')),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.onTextInput('test'),
      expect: () => [
        const SearchLoading(),
        const SearchError('Failed to load data'),
      ],
    );
  });

  group('resetSearch', () {
    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchInitial with history',
      setUp: () {
        when(
          () => mockSharedPrefs.searchHistory,
        ).thenReturn(['old', 'history']);
      },
      build: () => cubit,
      act: (cubit) => cubit.resetSearch(),
      expect: () => [
        const SearchInitial(searchHistory: ['old', 'history']),
      ],
    );
  });

  group('onSearchSubmit', () {
    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchInitial with history when query is empty',
      setUp: () {
        when(
          () => mockSharedPrefs.searchHistory,
        ).thenReturn(['test1', 'test2']);
      },
      build: () => cubit,
      act: (cubit) => cubit.onSearchSubmit(''),
      expect: () => [
        const SearchInitial(searchHistory: ['test1', 'test2']),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'searches by name and adds query to history',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => Right(PoisonListDataModel(poisons: tPoisons)),
        );
        when(
          () => mockSearchHistoryManager.addToHistory(any()),
        ).thenAnswer((_) async => {});
      },
      build: () => cubit,
      act: (cubit) => cubit.onSearchSubmit('aspirin'),
      expect: () => [
        const SearchLoading(),
        SearchLoaded(results: [tPoisons[1]], query: 'aspirin'),
      ],
      verify: (_) {
        verify(() => mockSearchHistoryManager.addToHistory('aspirin'))
            .called(1);
      },
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'searches by alias and adds query to history',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => Right(PoisonListDataModel(poisons: tPoisons)),
        );
        when(
          () => mockSearchHistoryManager.addToHistory(any()),
        ).thenAnswer((_) async => {});
      },
      build: () => cubit,
      act: (cubit) => cubit.onSearchSubmit('acetaminophen'),
      expect: () => [
        const SearchLoading(),
        SearchLoaded(results: [tPoisons[2]], query: 'acetaminophen'),
      ],
      verify: (_) {
        verify(
          () => mockSearchHistoryManager.addToHistory('acetaminophen'),
        ).called(1);
      },
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchError when no results found',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => const Right(PoisonListDataModel(poisons: [])),
        );
        when(
          () => mockSearchHistoryManager.addToHistory(any()),
        ).thenAnswer((_) async => {});
      },
      build: () => cubit,
      act: (cubit) => cubit.onSearchSubmit('unknown'),
      expect: () => [const SearchLoading(), const SearchError('unknown')],
      verify: (_) {
        verify(() => mockSearchHistoryManager.addToHistory('unknown'))
            .called(1);
      },
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchError when repository fails',
      setUp: () {
        when(() => mockRepository.getAllPoisons()).thenAnswer(
          (_) async => const Left(UnexpectedFailure(message: 'Failed')),
        );
        when(
          () => mockSearchHistoryManager.addToHistory(any()),
        ).thenAnswer((_) async => {});
      },
      build: () => cubit,
      act: (cubit) => cubit.onSearchSubmit('test'),
      expect: () => [
        const SearchLoading(),
        const SearchError('Failed to load data'),
      ],
      verify: (_) {
        verify(() => mockSearchHistoryManager.addToHistory('test')).called(1);
      },
    );
  });

  group('loadSearchHistory', () {
    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits SearchInitial with history when history is not empty',
      setUp: () {
        when(
          () => mockSharedPrefs.searchHistory,
        ).thenReturn(['item1', 'item2']);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadSearchHistory(),
      expect: () => [
        const SearchInitial(searchHistory: ['item1', 'item2']),
      ],
    );

    blocTest<SearchPoisonsCubit, SearchPoisonsState>(
      'emits nothing when history is empty',
      setUp: () {
        when(() => mockSharedPrefs.searchHistory).thenReturn([]);
      },
      build: () => cubit,
      act: (cubit) => cubit.loadSearchHistory(),
      expect: () => [],
    );
  });
}
