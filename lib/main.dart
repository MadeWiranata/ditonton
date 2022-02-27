import 'package:aplikasiditonton/common/constants.dart';
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
import 'package:aplikasiditonton/presentation/pages/about_page.dart';
import 'package:aplikasiditonton/presentation/pages/movie_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/home_movie_page.dart';
import 'package:aplikasiditonton/presentation/pages/popular_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/about_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:aplikasiditonton/injection.dart' as di;
import 'package:aplikasiditonton/injection_tv.dart' as tv;
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart';

void main() {
  di.init();
  //tv.init();
  runApp(const MyApp());
  tv.init();
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
          create: (_) => tv.locator<TVNowPlayingCubit>(),
        ),
        BlocProvider(
          create: (_) => tv.locator<TVDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => tv.locator<SearchTVBloc>(),
        ),
        BlocProvider(
          create: (_) => tv.locator<TVTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => tv.locator<TVPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => tv.locator<TVWatchlistCubit>(),
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
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
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
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            // case TVSeriesPage.ROUTE_NAME:
            // return MaterialPageRoute(builder: (_) => TVSeriesPage());
//penambahan
            case HomeTVPage.ROUTE_NAME:
              //tv.init();
              return MaterialPageRoute(builder: (_) => const HomeTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVPage());
            case TVDetailPage.ROUTE_NAME:
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
            case AboutPageTV.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPageTV());
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
