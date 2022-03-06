import 'package:core/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class WatchlistTVPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTVPage({Key? key}) : super(key: key);

  @override
  _WatchlistTVPageState createState() => _WatchlistTVPageState();
}

class _WatchlistTVPageState extends State<WatchlistTVPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<TVWatchlistCubit>().fetchWatchlist();
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
    Provider.of<TVWatchlistCubit>(context, listen: false).fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVWatchlistCubit, TVWatchlistState>(
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
                  final tv = watchlist.watchlist[index];
                  return TVCard(tv);
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
