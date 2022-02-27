import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'movie_top_rated_state.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  final GetTopRatedMovies topRatedMovies;

  MovieTopRatedCubit({
    required this.topRatedMovies,
  }) : super(MovieTopRatedInitial());

  void fetchTopRatedMovie() async {
    emit(MovieTopRatedLoading());

    final result = await topRatedMovies.execute();

    result.fold(
      (failure) async {
        emit(MovieTopRatedError(failure.message));
      },
      (data) async {
        emit(MovieTopRatedLoaded(data));
      },
    );
  }
}
