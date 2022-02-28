import 'package:aplikasiditonton/data/datasources/db/tv/database_helper.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'data/datasources/tv/tv_local_data_source.dart';
import 'data/datasources/tv/tv_remote_data_source.dart';
import 'data/repositories/tv/tv_repository_impl.dart';
import 'domain/repositories/tv/tv_repository.dart';
import 'domain/usecases/tv/get_now_playing_tv.dart';
import 'domain/usecases/tv/get_popular_tv.dart';
import 'domain/usecases/tv/get_top_rated_tv.dart';
import 'domain/usecases/tv/get_tv_detail.dart';
import 'domain/usecases/tv/get_tv_recommendations.dart';
import 'domain/usecases/tv/get_watchlist_status.dart';
import 'domain/usecases/tv/get_watchlist_tv.dart';
import 'domain/usecases/tv/remove_watchlist.dart';
import 'domain/usecases/tv/save_watchlist.dart';
import 'domain/usecases/tv/search_tv.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => TVNowPlayingCubit(
      nowPlayingTV: locator(),
    ),
  );
  locator.registerFactory(
    () => TVDetailCubit(
      tvDetail: locator(),
      tvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTVBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TVPopularCubit(
      popularTV: locator(),
    ),
  );
  locator.registerFactory(
    () => TVTopRatedCubit(
      topRatedTV: locator(),
    ),
  );
  locator.registerFactory(
    () => TVWatchlistCubit(
      watchlist: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));

  // repository
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
