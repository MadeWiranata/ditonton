import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

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
