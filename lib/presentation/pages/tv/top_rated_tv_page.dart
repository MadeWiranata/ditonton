import 'package:aplikasiditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:aplikasiditonton/presentation/widgets/tv/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTVPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-tv';
  const TopRatedTVPage({Key? key}) : super(key: key);

  @override
  _TopRatedTVPageState createState() => _TopRatedTVPageState();
}

class _TopRatedTVPageState extends State<TopRatedTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TVTopRatedCubit>().fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVTopRatedCubit, TVTopRatedState>(
          builder: (context, data) {
            if (data is TVTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TVTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = data.topRatedTv[index];
                  return TVCard(tvs);
                },
                itemCount: data.topRatedTv.length,
              );
            } else if (data is TVTopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
