// Mocks generated by Mockito 5.0.16 from annotations
// in tv_series/test/presentation/pages/tv_series_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: unnecessary_overrides

import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i13;
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_tv.dart'
    as _i6;
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_status.dart'
    as _i7;
import 'package:aplikasiditonton/domain/usecases/tv/remove_watchlist.dart'
    as _i9;
import 'package:aplikasiditonton/domain/usecases/tv/save_watchlist.dart' as _i8;
import 'package:aplikasiditonton/presentation/cubit/tv/tvwatchlist_cubit.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart' as _i14;
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_detail.dart' as _i2;
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_recommendations.dart'
    as _i3;
import 'package:aplikasiditonton/presentation/cubit/tv/tv_detail_cubit.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetDetailTV_0 extends _i1.Fake implements _i2.GetTVDetail {}

class _FakeGetRecommendationTV_1 extends _i1.Fake
    implements _i3.GetTVRecommendations {}

class _FakeTVDetailState_2 extends _i1.Fake implements _i4.TVDetailState {}

class _FakeStreamSubscription_3<T> extends _i1.Fake
    implements _i5.StreamSubscription<T> {}

class _FakeGetWatchlist_4 extends _i1.Fake implements _i6.GetWatchlistTV {}

class _FakeGetWatchListStatus_5 extends _i1.Fake
    implements _i7.GetWatchListStatus {}

class _FakeSaveWatchlist_6 extends _i1.Fake implements _i8.SaveWatchlist {}

class _FakeRemoveWatchlist_7 extends _i1.Fake implements _i9.RemoveWatchlist {}

class _FakeWatchlistState_8 extends _i1.Fake implements _i10.TVWatchlistState {}

/// A class which mocks [TVDetailCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVDetailCubit extends _i1.Mock implements _i4.TVDetailCubit {
  MockTVDetailCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTVDetail get tvDetail =>
      (super.noSuchMethod(Invocation.getter(#detailTV),
          returnValue: _FakeGetDetailTV_0()) as _i2.GetTVDetail);
  @override
  _i3.GetTVRecommendations get tvRecommendations => (super.noSuchMethod(
      Invocation.getter(#recommendationTV),
      returnValue: _FakeGetRecommendationTV_1()) as _i3.GetTVRecommendations);
  @override
  _i4.TVDetailState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTVDetailState_2()) as _i4.TVDetailState);
  @override
  _i5.Stream<_i4.TVDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.TVDetailState>.empty())
          as _i5.Stream<_i4.TVDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void fetchDetailTv(int? id) =>
      super.noSuchMethod(Invocation.method(#fetchDetailTv, [id]),
          returnValueForMissingStub: null);
  @override
  _i5.StreamSubscription<_i4.TVDetailState> listen(
          void Function(_i4.TVDetailState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_3<_i4.TVDetailState>())
          as _i5.StreamSubscription<_i4.TVDetailState>);
  @override
  void emit(_i4.TVDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i13.Change<_i4.TVDetailState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [WatchlistCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistCubit extends _i1.Mock implements _i10.TVWatchlistCubit {
  MockWatchlistCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.GetWatchlistTV get watchlist =>
      (super.noSuchMethod(Invocation.getter(#watchlist),
          returnValue: _FakeGetWatchlist_4()) as _i6.GetWatchlistTV);
  @override
  _i7.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus_5()) as _i7.GetWatchListStatus);
  @override
  _i8.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist_6()) as _i8.SaveWatchlist);
  @override
  _i9.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist_7()) as _i9.RemoveWatchlist);
  @override
  _i10.TVWatchlistState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeWatchlistState_8()) as _i10.TVWatchlistState);
  @override
  _i5.Stream<_i10.TVWatchlistState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i10.TVWatchlistState>.empty())
          as _i5.Stream<_i10.TVWatchlistState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void loadWatchlistStatus(int? id) =>
      super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValueForMissingStub: null);
  @override
  void fetchWatchlist() =>
      super.noSuchMethod(Invocation.method(#fetchWatchlist, []),
          returnValueForMissingStub: null);
  @override
  void addWatchlist(_i14.TVDetail? movie) =>
      super.noSuchMethod(Invocation.method(#addWatchlist, [movie]),
          returnValueForMissingStub: null);
  @override
  void deleteWatchlist(_i14.TVDetail? id) =>
      super.noSuchMethod(Invocation.method(#deleteWatchlist, [id]),
          returnValueForMissingStub: null);
  @override
  _i5.StreamSubscription<_i10.TVWatchlistState> listen(
          void Function(_i10.TVWatchlistState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription_3<_i10.TVWatchlistState>())
          as _i5.StreamSubscription<_i10.TVWatchlistState>);
  @override
  void emit(_i10.TVWatchlistState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onChange(_i13.Change<_i10.TVWatchlistState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  _i5.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [EpisodeCubit].
///
/// See the documentation for Mockito's code generation for more information.
