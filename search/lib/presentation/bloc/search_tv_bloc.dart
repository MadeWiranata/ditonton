import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/transformers.dart';
import 'package:tv/domain/entities/tv.dart';
part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTVBloc extends Bloc<SearchTVEvent, SearchTVState> {
  final SearchTV searchTV;

  SearchTVBloc({required this.searchTV}) : super(SearchTVInitial()) {
    on<OnChangeTvQuery>((event, emit) async {
      final query = event.query;

      emit(SearchTVLoading());

      final result = await searchTV.execute(query);

      result.fold(
        (failure) {
          emit(SearchTVError(failure.message));
        },
        (result) {
          emit(SearchTVHasData(result));
        },
      );
    }, transformer: _debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnChangeTvQuery> _debounce<OnChangeTvQuery>(
          Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
