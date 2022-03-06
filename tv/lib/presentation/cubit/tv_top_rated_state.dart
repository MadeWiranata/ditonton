part of 'tv_top_rated_cubit.dart';

@immutable
abstract class TVTopRatedState extends Equatable {
  const TVTopRatedState();

  @override
  List<Object?> get props => [];
}

class TVTopRatedInitial extends TVTopRatedState {}

class TVTopRatedLoading extends TVTopRatedState {}

class TVTopRatedLoaded extends TVTopRatedState {
  final List<Tv> topRatedTv;

  const TVTopRatedLoaded(this.topRatedTv);

  @override
  List<Object?> get props => [topRatedTv];
}

class TVTopRatedError extends TVTopRatedState {
  final String message;

  const TVTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
