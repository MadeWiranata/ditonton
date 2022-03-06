import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status.dart';
import 'package:core/domain/usecases/movies/remove_watchlist.dart';
import 'package:core/domain/usecases/movies/save_watchlist.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist.dart';
import 'package:core/domain/usecases/tv/save_watchlist.dart';
import 'package:core/presentation/cubit/movies/watchlist_cubit.dart';
import 'package:core/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movies/data/datasource/movie_local_data_source.dart';
import 'package:movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/presentation/cubit/movie_detail_cubit.dart';
import 'package:movies/presentation/cubit/movie_now_playing_cubit.dart';
import 'package:movies/presentation/cubit/movie_popular_cubit.dart';
import 'package:movies/presentation/cubit/movie_top_rated_cubit.dart';
import 'package:search/domain/usecases/movies/search_movies.dart';
import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/cubit/tv_detail_cubit.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';

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
