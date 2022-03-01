// Mocks generated by Mockito 5.0.16 from annotations
// in core/test/presentation/cubit/watchlist_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: unnecessary_overrides

import 'dart:async' as _i5;
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_tv.dart'
    as _i4;
import 'package:aplikasiditonton/domain/usecases/tv/get_watchlist_status.dart'
    as _i7;
import 'package:aplikasiditonton/domain/usecases/tv/remove_watchlist.dart'
    as _i10;
import 'package:aplikasiditonton/domain/usecases/tv/save_watchlist.dart' as _i8;
import 'package:aplikasiditonton/common/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart' as _i9;
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart'
    as _i3;
import 'package:aplikasiditonton/domain/entities/tv/tv.dart' as _i11;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTVRepository_1 extends _i1.Fake implements _i3.TVRepository {}

/// A class which mocks [GetWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVWatchlist extends _i1.Mock implements _i4.GetWatchlistTV {
  MockGetTVWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i11.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i2.Either<_i6.Failure, List<_i11.Tv>>>.value(
                  _FakeEither_0<_i6.Failure, List<_i11.Tv>>()))
          as _i5.Future<_i2.Either<_i6.Failure, List<_i11.Tv>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i7.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_1()) as _i3.TVRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i8.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_1()) as _i3.TVRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i9.TVDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i10.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository_1()) as _i3.TVRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i9.TVDetail id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
  @override
  String toString() => super.toString();
}
