import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/tv/get_watchlist_status.dart';
import '../../../domain/usecases/tv/remove_watchlist.dart';
import '../../../domain/usecases/tv/save_watchlist.dart';
part 'tv_detail_state.dart';

class TVDetailCubit extends Cubit<TVDetailState> {
  final GetTVDetail detailTV;
  final GetTVRecommendations recommendationTV;
  final GetWatchListStatus watchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TVDetailCubit({
    required this.detailTV,
    required this.recommendationTV,
    required this.watchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVDetailInitial());

  void fetchDetailTv(int id) async {
    emit(TVDetailLoading());

    final result = await detailTV.execute(id);
    final recommendation = await recommendationTV.execute(id);

    result.fold(
      (failure) async {
        emit(TVDetailError(failure.message));
      },
      (detail) async {
        emit(TVRecommendationLoading());

        recommendation.fold(
          (failure) async {
            emit(TVRecommendationError(failure.message));
          },
          (recomendation) async {
            emit(TVDetailLoaded(detail, recomendation));
          },
        );
      },
    );
  }
}
