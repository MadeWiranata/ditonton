part of 'tv_popular_cubit.dart';

@immutable
abstract class TVPopularState extends Equatable {
  const TVPopularState();

  @override
  List<Object?> get props => [];
}

class TVPopularInitial extends TVPopularState {}

class TVPopularLoading extends TVPopularState {}

class TVPopularLoaded extends TVPopularState {
  final List<Tv> popularTV;

  const TVPopularLoaded(this.popularTV);

  @override
  List<Object?> get props => [popularTV];
}

class TVPopularError extends TVPopularState {
  final String message;

  const TVPopularError(this.message);

  @override
  List<Object?> get props => [message];
}
