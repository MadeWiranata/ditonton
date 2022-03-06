import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class PopularTVPage extends StatefulWidget {
  const PopularTVPage({Key? key}) : super(key: key);

  @override
  _PopularTVPageState createState() => _PopularTVPageState();
}

class _PopularTVPageState extends State<PopularTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TVPopularCubit>().fetchPopularTv(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TVPopularCubit, TVPopularState>(
          builder: (context, data) {
            if (data is TVPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TVPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = data.popularTV[index];
                  return TVCard(tvs);
                },
                itemCount: data.popularTV.length,
              );
            } else if (data is TVPopularError) {
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
