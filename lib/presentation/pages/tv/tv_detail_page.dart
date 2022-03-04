import 'package:aplikasiditonton/domain/entities/tv/genre.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_style.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVDetailPage extends StatefulWidget {
  final int id;
  const TVDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Future.microtask(() {
          context.read<TVDetailCubit>().fetchDetailTv(widget.id);
          context.read<TVWatchlistCubit>().loadWatchlistStatus(widget.id);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TVWatchlistCubit, TVWatchlistState>(
      listenWhen: (context, state) => state is WatchlistMessage,
      listener: (context, message) {
        if (message is WatchlistMessage) {
          if (message.watchlistMessage ==
                  TVWatchlistCubit.addWatchlistMessage ||
              message.watchlistMessage ==
                  TVWatchlistCubit.removeWatchlistMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message.watchlistMessage),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message.watchlistMessage),
                );
              },
            );
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<TVDetailCubit, TVDetailState>(
          builder: (context, detail) {
            return BlocBuilder<TVWatchlistCubit, TVWatchlistState>(
              builder: (context, status) {
                if (detail is TVDetailLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (detail is TVDetailLoaded &&
                    status is WatchlistStatus) {
                  return SafeArea(
                    child: DetailContent(
                      tv: detail.tvDetail,
                      isAddedWatchlist: status.isAddedToWatchlist,
                    ),
                  );
                } else if (detail is TVDetailError) {
                  return Text(detail.message);
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVDetail tv;
  final bool isAddedWatchlist;

  const DetailContent({
    Key? key,
    required this.tv,
    required this.isAddedWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.poster_path}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final data = TVDetail(
                                  backdrop_path: tv.backdrop_path,
                                  genres: tv.genres,
                                  id: tv.id,
                                  original_name: tv.original_name,
                                  overview: tv.overview,
                                  poster_path: tv.poster_path,
                                  first_air_date: tv.first_air_date,
                                  name: tv.name,
                                  voteAverage: tv.voteAverage,
                                  voteCount: tv.voteCount,
                                );
                                if (!isAddedWatchlist) {
                                  context.read<TVWatchlistCubit>()
                                    ..addWatchlist(data)
                                    ..fetchWatchlist();
                                } else {
                                  context.read<TVWatchlistCubit>()
                                    ..deleteWatchlist(data)
                                    ..fetchWatchlist();
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            //Text(
                            //  _showDuration(movie.runtime),
                            // ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVDetailCubit, TVDetailState>(
                              builder: (context, recommendations) {
                                if (recommendations
                                    is TVRecommendationLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (recommendations
                                    is TVRecommendationError) {
                                  return Text(
                                    recommendations.message,
                                    key: const Key('recommended_error'),
                                  );
                                } else if (recommendations is TVDetailLoaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key('recommended_list'),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations
                                            .recommendationTv[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TV_DETAIL_ROUTE,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.poster_path}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations
                                          .recommendationTv.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  // ignore: unused_element
  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
