part of 'tv_now_playing_cubit.dart';

@immutable
abstract class TVNowPlayingState extends Equatable {
  const TVNowPlayingState();

  @override
  List<Object?> get props => [];
}

class TVNowPlayingInitial extends TVNowPlayingState {}

class TVNowPlayingLoading extends TVNowPlayingState {}

class TVNowPlayingLoaded extends TVNowPlayingState {
  final List<Tv> nowPlayingTV;

  const TVNowPlayingLoaded(this.nowPlayingTV);

  @override
  List<Object?> get props => [nowPlayingTV];
}

class TVNowPlayingError extends TVNowPlayingState {
  final String message;

  const TVNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
