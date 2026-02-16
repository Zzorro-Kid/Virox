import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/shared_prefs.dart';
import 'features/all_poisons_screen/presentation/cubit/all_poisons_cubit.dart';
import 'features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'features/main_screen/presentation/utils/list_shuffler.dart';
import 'features/search_screen/data/repositories/poison_repository_impl.dart';
import 'features/search_screen/data/sources/local/poisons_local_data_source.dart';
import 'features/search_screen/data/sources/remote/poisons_remote_data_source.dart';
import 'features/search_screen/domain/repositories/poison_repository.dart';
import 'features/search_screen/presentation/cubit/search_poisons/search_poisons_cubit.dart';
import 'features/search_screen/presentation/utils/search_history_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initExternal();
  _initBloc();
  _initRepositories();
  _initDataSources();
  _initCore();
}

Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(() => sharedPreferences);
}

void _initBloc() {
  sl
    ..registerFactory(
      () => SearchPoisonsCubit(
        repository: sl(),
        sharedPrefs: sl(),
        searchHistoryManager: sl(),
      ),
    )
    ..registerFactory(
      () => MainScreenCubit(repository: sl(), listShuffler: sl()),
    )
    ..registerFactory(
      () => AllPoisonsCubit(repository: sl(), listShuffler: sl()),
    );
}

void _initRepositories() {
  sl.registerLazySingleton<PoisonRepository>(
    () => PoisonRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
}

void _initDataSources() {
  sl
    ..registerLazySingleton<PoisonRemoteDataSource>(
      () => PoisonRemoteDataSourceImpl(client: sl(), sharedPref: sl()),
    )
    ..registerLazySingleton<PoisonLocalDataSource>(
      () => PoisonLocalDataSourceImpl(sharedPref: sl()),
    );
}

void _initCore() {
  sl
    ..registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new)
    ..registerLazySingleton(() => SharedPrefs(sl()))
    ..registerLazySingleton(() => SearchHistoryManager(sharedPrefs: sl()))
    ..registerLazySingleton(ListShuffler.new);
}
