import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingCubit extends Cubit<MovieNowPlayingState> {
  final GetNowPlayingMovies nowPlayingMovies;

  MovieNowPlayingCubit({
    required this.nowPlayingMovies,
  }) : super(MovieNowPlayingInitial());

  void fetchNowPlayingMovie() async {
    emit(MovieNowPlayingLoading());

    final result = await nowPlayingMovies.execute();

    result.fold(
      (failure) async {
        emit(MovieNowPlayingError(failure.message));
      },
      (data) async {
        emit(MovieNowPlayingLoaded(data));
      },
    );
  }
}
