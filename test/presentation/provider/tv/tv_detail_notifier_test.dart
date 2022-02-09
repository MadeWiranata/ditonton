import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:aplikasiditonton/domain/usecases/get_watchlist_status.dart';
import 'package:aplikasiditonton/domain/usecases/remove_watchlist.dart';
import 'package:aplikasiditonton/domain/usecases/save_watchlist.dart';
import 'package:aplikasiditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:aplikasiditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
import 'TV_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TVDetailNotifier provider;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = TVDetailNotifier(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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
  final tTVs = <Tv>[tTV];

  void _arrangeUsecase() {
    when(mockGetTVDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    when(mockGetTVRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTVs));
  }

  group('Get TV Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVDetail.execute(tId));
      verify(mockGetTVRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTVDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation TVs when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTVs);
    });
  });

  group('Get TV Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      verify(mockGetTVRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTVs);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTVs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTVDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTVDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTVDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTVDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTVDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTVs));
      // act
      await provider.fetchTVDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
