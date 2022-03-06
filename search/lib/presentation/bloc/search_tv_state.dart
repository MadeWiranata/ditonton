part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTVState extends Equatable {
  const SearchTVState();

  @override
  List<Object?> get props => [];
}

class SearchTVInitial extends SearchTVState {}

class SearchTVLoading extends SearchTVState {}

class SearchTVHasData extends SearchTVState {
  final List<Tv> result;

  const SearchTVHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchTVError extends SearchTVState {
  final String message;

  const SearchTVError(this.message);

  @override
  List<Object?> get props => [message];
}
