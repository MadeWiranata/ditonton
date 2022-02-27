import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_now_playing_state.dart';

class TVNowPlayingCubit extends Cubit<TVNowPlayingState> {
  final GetNowPlayingTV nowPlayingTV;

  TVNowPlayingCubit({
    required this.nowPlayingTV,
  }) : super(TVNowPlayingInitial());

  void fetchNowPlayingTv() async {
    emit(TVNowPlayingLoading());

    final result = await nowPlayingTV.execute();

    result.fold(
      (failure) async {
        emit(TVNowPlayingError(failure.message));
      },
      (data) async {
        emit(TVNowPlayingLoaded(data));
      },
    );
  }
}
