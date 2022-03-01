part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchMoviesInitial extends SearchState {}

class SearchMoviesLoading extends SearchState {}

class SearchMoviesHasData extends SearchState {
  final List<Movie> result;

  const SearchMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchMoviesError extends SearchState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
