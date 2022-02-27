import 'package:aplikasiditonton/domain/usecases/tv/search_tv.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_event.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_state.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/transformers.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTV _searchTV;

  SearchTVBloc(this._searchTV) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTV.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
