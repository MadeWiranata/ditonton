import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/entities/movie_detail.dart';
import 'package:aplikasiditonton/domain/usecases/get_movie_detail.dart';
import 'package:aplikasiditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial());

  void fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());

    final detail = await getMovieDetail.execute(id);
    final recommendation = await getMovieRecommendations.execute(id);

    detail.fold((failure) async {
      emit(MovieDetailError(failure.message));
    }, (detail) async {
      emit(MovieRecommendationLoading());
      recommendation.fold(
        (failure) async {
          emit(MovieRecommendationError(failure.message));
        },
        (recommendation) async {
          emit(MovieDetailLoaded(detail, recommendation));
        },
      );
    });
  }
}
