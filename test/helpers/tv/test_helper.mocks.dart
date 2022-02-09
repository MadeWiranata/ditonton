// Mocks generated by Mockito 5.0.8 from annotations
// in aplikasiditonton/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;
import 'dart:convert' as _i18;
import 'dart:typed_data' as _i19;

import 'package:dartz/dartz.dart' as _i2;
import 'package:aplikasiditonton/common/failure.dart' as _i8;
import 'package:aplikasiditonton/data/datasources/db/tv/database_helper.dart'
    as _i15;
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart'
    as _i13;
import 'package:aplikasiditonton/data/datasources/tv/tv_remote_data_source.dart'
    as _i11;
import 'package:aplikasiditonton/data/models/tv/tv_detail_model.dart' as _i3;
import 'package:aplikasiditonton/data/models/tv/tv_model.dart' as _i12;
import 'package:aplikasiditonton/data/models/tv/tv_table.dart' as _i14;
import 'package:aplikasiditonton/domain/entities/tv/tv.dart' as _i9;
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart' as _i10;
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart'
    as _i6;
import 'package:http/src/base_request.dart' as _i20;
import 'package:http/src/client.dart' as _i17;
import 'package:http/src/response.dart' as _i4;
import 'package:http/src/streamed_response.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_common/sqlite_api.dart' as _i16;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTVDetailResponse extends _i1.Fake implements _i3.TVDetailResponse {}

class _FakeResponse extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse extends _i1.Fake implements _i5.StreamedResponse {}

/// A class which mocks [TVRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRepository extends _i1.Mock implements _i6.TVRepository {
  MockTVRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getNowPlayingTV() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTV, []),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.TVDetail>> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue: Future<_i2.Either<_i8.Failure, _i10.TVDetail>>.value(
                  _FakeEither<_i8.Failure, _i10.TVDetail>()))
          as _i7.Future<_i2.Either<_i8.Failure, _i10.TVDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getTVRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlist(
          _i10.TVDetail? TV) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [TV]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlist(
          _i10.TVDetail? TV) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [TV]),
              returnValue: Future<_i2.Either<_i8.Failure, String>>.value(
                  _FakeEither<_i8.Failure, String>()))
          as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTV, []),
              returnValue: Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i8.Failure, List<_i9.Tv>>()))
          as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Tv>>>);
}

/// A class which mocks [TVRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRemoteDataSource extends _i1.Mock
    implements _i11.TVRemoteDataSource {
  MockTVRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.TVModel>> getNowPlayingTVs() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTVs, []),
              returnValue: Future<List<_i12.TVModel>>.value(<_i12.TVModel>[]))
          as _i7.Future<List<_i12.TVModel>>);
  @override
  _i7.Future<List<_i12.TVModel>> getPopularTVs() =>
      (super.noSuchMethod(Invocation.method(#getPopularTVs, []),
              returnValue: Future<List<_i12.TVModel>>.value(<_i12.TVModel>[]))
          as _i7.Future<List<_i12.TVModel>>);
  @override
  _i7.Future<List<_i12.TVModel>> getTopRatedTVs() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTVs, []),
              returnValue: Future<List<_i12.TVModel>>.value(<_i12.TVModel>[]))
          as _i7.Future<List<_i12.TVModel>>);
  @override
  _i7.Future<_i3.TVDetailResponse> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue:
                  Future<_i3.TVDetailResponse>.value(_FakeTVDetailResponse()))
          as _i7.Future<_i3.TVDetailResponse>);
  @override
  _i7.Future<List<_i12.TVModel>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue: Future<List<_i12.TVModel>>.value(<_i12.TVModel>[]))
          as _i7.Future<List<_i12.TVModel>>);
  @override
  _i7.Future<List<_i12.TVModel>> searchTVs(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVs, [query]),
              returnValue: Future<List<_i12.TVModel>>.value(<_i12.TVModel>[]))
          as _i7.Future<List<_i12.TVModel>>);
}

/// A class which mocks [TVLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVLocalDataSource extends _i1.Mock implements _i13.TVLocalDataSource {
  MockTVLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlist(_i14.TVTable? TV) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [TV]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlist(_i14.TVTable? TV) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [TV]),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i14.TVTable?> getTVById(int? id) => (super.noSuchMethod(
      Invocation.method(#getTVById, [id]),
      returnValue: Future<_i14.TVTable?>.value()) as _i7.Future<_i14.TVTable?>);
  @override
  _i7.Future<List<_i14.TVTable>> getWatchlistTVs() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVs, []),
              returnValue: Future<List<_i14.TVTable>>.value(<_i14.TVTable>[]))
          as _i7.Future<List<_i14.TVTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i15.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i16.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i16.Database?>.value())
          as _i7.Future<_i16.Database?>);
  @override
  _i7.Future<int> insertWatchlistTV(_i14.TVTable? TV) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [TV]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistTV(_i14.TVTable? TV) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [TV]),
          returnValue: Future<int>.value(0)) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTVById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTV() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTVs, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i17.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i18.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse()))
          as _i7.Future<_i4.Response>);
  @override
  _i7.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i7.Future<String>);
  @override
  _i7.Future<_i19.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i19.Uint8List>.value(_i19.Uint8List(0)))
          as _i7.Future<_i19.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i20.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i5.StreamedResponse>.value(_FakeStreamedResponse()))
          as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
