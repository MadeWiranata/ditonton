// Mocks generated by Mockito 5.0.8 from annotations
// in aplikasiditonton/test/presentation/provider/TV_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:aplikasiditonton/common/failure.dart' as _i6;
import 'package:aplikasiditonton/domain/entities/tv/tv.dart' as _i9;
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart' as _i7;
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart'
    as _i2;
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_detail.dart' as _i4;
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_recommendations.dart'
    as _i8;
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_status.dart'
    as _i10;
import 'package:aplikasiditonton/domain/usecases/tv/remove_watchlist.dart'
    as _i12;
import 'package:aplikasiditonton/domain/usecases/tv/save_watchlist.dart'
    as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTVRepository extends _i1.Fake implements _i2.TVRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTVDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVDetail extends _i1.Mock implements _i4.GetTVDetail {
  MockGetTVDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.TVDetail>>.value(
                  _FakeEither<_i6.Failure, _i7.TVDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>>);
}

/// A class which mocks [GetTVRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVRecommendations extends _i1.Mock
    implements _i8.GetTVRecommendations {
  MockGetTVRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Tv>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i6.Failure, List<_i9.Tv>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i9.Tv>>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i10.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i11.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TVDetail? Tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [Tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i12.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TVDetail? Tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [Tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}