// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_declarations, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:aplikasiditonton/common/state_enum.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/search_tv.dart';
import 'package:aplikasiditonton/presentation/provider/tv/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'TV_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTV mockSearchTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTV = MockSearchTV();
    provider = TVSearchNotifier(searchTV: mockSearchTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVModel = Tv(
    backdrop_path: '/mC32mlq894Lho4zXK6NUKnZcRgF.jpg',
    genreIds: [18],
    id: 39483,
    original_name: 'Major Crimes',
    overview:
        'Major Crimes explores how the American justice system approaches the art of the deals as law enforcement officers and prosecutors work together to score a conviction. Los Angeles Police Captain Sharon Raydor heads up a special squad within the LAPD that deals with high-profile or particularly sensitive crimes.',
    popularity: 8.724475,
    poster_path: '/4kUtFpFb2WsdiH4kqZwoNvodMRZ.jpg',
    first_air_date: '2012-08-13',
    name: 'Major Crimes',
    voteAverage: 6.5,
    voteCount: 17,
  );
  final tTVList = <Tv>[tTVModel];
  final tQuery = 'major crimes';

  group('search TVs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
