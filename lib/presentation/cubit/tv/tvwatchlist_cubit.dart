import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../domain/usecases/tv/remove_watchlist.dart';
import '../../../domain/usecases/tv/save_watchlist.dart';
part 'tvwatchlist_state.dart';

class TVWatchlistCubit extends Cubit<TVWatchlistState> {
  final GetWatchlistTV watchlist;
  final TVGetWatchListStatus getWatchListStatus;
  final TVSaveWatchlist saveWatchlist;
  final TVRemoveWatchlist removeWatchlist;

  static const addWatchlistMessage = 'Added to Watchlist';
  static const removeWatchlistMessage = 'Removed from Watchlist';

  TVWatchlistCubit({
    required this.watchlist,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(WatchlistInitial());

  void loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(WatchlistStatus(result));
  }

  void fetchWatchlist() async {
    emit(WatchlistLoading());

    final result = await watchlist.execute();

    result.fold(
      (failure) async {
        emit(WatchlistError(failure.message));
      },
      (data) async {
        emit(WatchlistLoaded(data));
      },
    );
  }

  void addWatchlist(TVDetail tv) async {
    final result = await saveWatchlist.execute(tv);
    await result.fold(
      (failure) async {
        emit(WatchlistMessage(failure.message));
      },
      (message) async {
        emit(WatchlistMessage(message));
      },
    );

    loadWatchlistStatus(tv.id);
  }

  void deleteWatchlist(TVDetail tv) async {
    final result = await removeWatchlist.execute(tv);
    await result.fold(
      (failure) async {
        emit(WatchlistMessage(failure.message));
      },
      (message) async {
        emit(WatchlistMessage(message));
      },
    );

    loadWatchlistStatus(tv.id);
  }
}
