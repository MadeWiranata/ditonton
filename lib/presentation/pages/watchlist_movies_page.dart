import 'package:aplikasiditonton/common/utils.dart';
import 'package:aplikasiditonton/presentation/cubit/watchlist_cubit.dart';
import 'package:aplikasiditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<WatchlistCubit>().fetchWatchlist();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistCubit>(context, listen: false).fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, watchlist) {
            if (watchlist is WatchlistInitial) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: const Center(
                  key: Key('empty_message'),
                  child: Text(
                    'Watchlist is Empty',
                  ),
                ),
              );
            } else if (watchlist is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (watchlist is WatchlistLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = watchlist.watchlist[index];
                  return MovieCard(movie);
                },
                itemCount: watchlist.watchlist.length,
              );
            } else if (watchlist is WatchlistMessage) {
              return Center(
                key: const Key('error_message'),
                child: Text(watchlist.watchlistMessage),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
