import 'package:aplikasiditonton/data/datasources/db/tv/database_helper.dart';
import 'package:aplikasiditonton/data/datasources/movie_local_data_source.dart';
import 'package:aplikasiditonton/data/datasources/movie_remote_data_source.dart';
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart';
import 'package:aplikasiditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:aplikasiditonton/data/repositories/movie_repository_impl.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';
import 'package:aplikasiditonton/domain/usecases/get_movie_detail.dart';
import 'package:aplikasiditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:aplikasiditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:aplikasiditonton/domain/usecases/get_popular_movies.dart';
import 'package:aplikasiditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:aplikasiditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:aplikasiditonton/domain/usecases/get_watchlist_status.dart';
import 'package:aplikasiditonton/domain/usecases/remove_watchlist.dart';
import 'package:aplikasiditonton/domain/usecases/save_watchlist.dart';
import 'package:aplikasiditonton/domain/usecases/search_movies.dart';
import 'package:aplikasiditonton/presentation/bloc/search_bloc.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:aplikasiditonton/presentation/cubit/movie_detail_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/movie_now_playing_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/movie_popular_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/movie_top_rated_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/watchlist_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
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
    () => MovieNowPlayingCubit(
      nowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistCubit(
      watchlist: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularCubit(
      popularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedCubit(
      topRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchBloc(
      searchMovies: locator(),
    ),
  );
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
      searchTV: locator(),
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
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => GetPopularTV(locator()));
  locator.registerLazySingleton(() => GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTV(locator()));
  locator.registerLazySingleton(() => TVGetWatchListStatus(locator()));
  locator.registerLazySingleton(() => TVSaveWatchlist(locator()));
  locator.registerLazySingleton(() => TVRemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTV(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
