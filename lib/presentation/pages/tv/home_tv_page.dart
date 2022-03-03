import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_now_playing_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_top_rated_cubit.dart';
import 'package:aplikasiditonton/presentation/pages/home_movie_page.dart';
import 'package:aplikasiditonton/presentation/pages/about_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/search_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:aplikasiditonton/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aplikasiditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTVPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/home-tv';
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVNowPlayingCubit>().fetchNowPlayingTv();
      context.read<TVPopularCubit>().fetchPopularTv();
      context.read<TVTopRatedCubit>().fetchTopRatedTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTV.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TVNowPlayingCubit, TVNowPlayingState>(
                  builder: (context, nowPlaying) {
                if (nowPlaying is TVNowPlayingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (nowPlaying is TVNowPlayingLoaded) {
                  return TVList(
                    key: const Key('now_playing_list'),
                    tvs: nowPlaying.nowPlayingTV,
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.ROUTE_NAME),
              ),
              BlocBuilder<TVPopularCubit, TVPopularState>(
                  builder: (context, popular) {
                if (popular is TVPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (popular is TVPopularLoaded) {
                  return TVList(
                    key: const Key('popular_list'),
                    tvs: popular.popularTV,
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.ROUTE_NAME),
              ),
              BlocBuilder<TVTopRatedCubit, TVTopRatedState>(
                  builder: (context, top) {
                if (top is TVTopRatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (top is TVTopRatedLoaded) {
                  return TVList(
                    key: const Key('top_rated_list'),
                    tvs: top.topRatedTv,
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<Tv> tvs;

  const TVList({Key? key, required this.tvs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.poster_path}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
