import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/usecases/get_popular_movies.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'movie_popular_state.dart';

class MoviePopularCubit extends Cubit<MoviePopularState> {
  final GetPopularMovies popularMovies;

  MoviePopularCubit({required this.popularMovies})
      : super(MoviePopularInitial());

  void fetchPopularMovie() async {
    emit(MoviePopularLoading());

    final result = await popularMovies.execute();

    result.fold(
      (failure) async {
        emit(MoviePopularError(failure.message));
      },
      (data) async {
        emit(MoviePopularLoaded(data));
      },
    );
  }
}
