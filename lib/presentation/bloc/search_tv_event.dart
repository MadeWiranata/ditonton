part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTVEvent extends Equatable {
  const SearchTVEvent();

  @override
  List<Object?> get props => [];
}

class OnChangeTvQuery extends SearchTVEvent {
  final String query;

  const OnChangeTvQuery(this.query);

  @override
  List<Object?> get props => [query];
}
