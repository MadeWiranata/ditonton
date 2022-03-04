import 'package:about/about_page.dart';
import 'package:aplikasiditonton/common/utils.dart';
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
import 'package:aplikasiditonton/presentation/pages/movie_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/home_movie_page.dart';
import 'package:aplikasiditonton/presentation/pages/popular_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:aplikasiditonton/injection.dart' as di;
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        //penambahan
        BlocProvider(
          create: (_) => di.locator<TVNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVWatchlistCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_MOVIE:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              TVLocalDataSourceImpl.KelasApa = "movie";
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case SEARCH_ROUTE:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case TV_HOME:
              return MaterialPageRoute(builder: (_) => const HomeTVPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => const PopularTVPage());
            case TV_TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVPage());
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTV.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPageTV());
            case WatchlistTVPage.ROUTE_NAME:
              TVLocalDataSourceImpl.KelasApa = "";
              return MaterialPageRoute(builder: (_) => const WatchlistTVPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
