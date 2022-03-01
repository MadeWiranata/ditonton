import 'package:aplikasiditonton/domain/usecases/search_movies.dart';
import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc({required this.searchMovies}) : super(SearchMoviesInitial()) {
    on<OnChangeMovieQuery>((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());

      final result = await searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (result) {
          emit(SearchMoviesHasData(result));
        },
      );
    }, transformer: _debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnChangeMovieQuery> _debounce<OnChangeMovieQuery>(
          Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
