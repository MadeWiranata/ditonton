part of 'tvwatchlist_cubit.dart';

@immutable
abstract class TVWatchlistState extends Equatable {
  const TVWatchlistState();

  @override
  List<Object?> get props => [];
}

class WatchlistInitial extends TVWatchlistState {}

class WatchlistLoading extends TVWatchlistState {}

class WatchlistLoaded extends TVWatchlistState {
  final List<dynamic> watchlist;

  const WatchlistLoaded(this.watchlist);

  @override
  List<Object?> get props => [watchlist];
}

class WatchlistError extends TVWatchlistState {
  final String error;

  const WatchlistError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchlistStatus extends TVWatchlistState {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object?> get props => [isAddedToWatchlist];
}

class WatchlistMessage extends TVWatchlistState {
  final String watchlistMessage;

  const WatchlistMessage(this.watchlistMessage);

  @override
  List<Object?> get props => [watchlistMessage];
}
