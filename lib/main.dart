import 'package:aplikasiditonton/common/constants.dart';
import 'package:aplikasiditonton/common/utils.dart';
import 'package:aplikasiditonton/presentation/bloc/search_bloc.dart';
import 'package:aplikasiditonton/presentation/pages/about_page.dart';
import 'package:aplikasiditonton/presentation/pages/movie_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/home_movie_page.dart';
import 'package:aplikasiditonton/presentation/pages/popular_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/popular_tvseries_page.dart';
import 'package:aplikasiditonton/presentation/pages/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:aplikasiditonton/presentation/pages/top_rated_tvseries_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/about_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/home_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:aplikasiditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/movie_list_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/tv/watchlist_tv_notifier.dart';
import 'package:aplikasiditonton/presentation/provider/watchlist_movie_notifier.dart';
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
  runApp(MyApp());
  tv.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        //ChangeNotifierProvider(
        //create: (_) => di.locator<MovieSearchNotifier>(),
        // ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        //penambahan
        ChangeNotifierProvider(
          create: (_) => tv.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tv.locator<TVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tv.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tv.locator<TopRatedTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tv.locator<PopularTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => tv.locator<WatchlistTVNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              TVLocalDataSourceImpl.KelasApa = "movie";
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            // case TVSeriesPage.ROUTE_NAME:
            // return MaterialPageRoute(builder: (_) => TVSeriesPage());
//penambahan
            case HomeTVPage.ROUTE_NAME:
              //tv.init();
              return MaterialPageRoute(builder: (_) => HomeTVPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTV.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTV());
            case WatchlistTVPage.ROUTE_NAME:
              TVLocalDataSourceImpl.KelasApa = "";
              return MaterialPageRoute(builder: (_) => WatchlistTVPage());
            case AboutPageTV.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPageTV());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
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
