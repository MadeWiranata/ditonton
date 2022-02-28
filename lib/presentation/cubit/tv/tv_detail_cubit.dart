import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'tv_detail_state.dart';

class TVDetailCubit extends Cubit<TVDetailState> {
  final GetTVDetail tvDetail;
  final GetTVRecommendations tvRecommendations;

  TVDetailCubit({
    required this.tvDetail,
    required this.tvRecommendations,
  }) : super(TVDetailInitial());

  void fetchDetailTv(int id) async {
    emit(TVDetailLoading());

    final result = await tvDetail.execute(id);
    final recommendation = await tvRecommendations.execute(id);

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
