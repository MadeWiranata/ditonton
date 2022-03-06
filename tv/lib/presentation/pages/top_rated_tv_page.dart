import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class TopRatedTVPage extends StatefulWidget {
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
