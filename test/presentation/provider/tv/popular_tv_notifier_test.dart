// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:aplikasiditonton/presentation/provider/tv/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late MockGetPopularTV mockGetPopularTVs;
  late PopularTVNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTVs = MockGetPopularTV();
    notifier = PopularTVNotifier(mockGetPopularTVs)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTV = Tv(
    backdrop_path: 'backdrop_path',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'original_name',
    overview: 'overview',
    popularity: 1,
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTVList = <Tv>[tTV];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchPopularTV();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change TVs data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTVs.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchPopularTV();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTVs.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTV();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
