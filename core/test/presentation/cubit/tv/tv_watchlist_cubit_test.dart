import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/usecases/tv/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecases/tv/remove_watchlist.dart';
import 'package:core/domain/usecases/tv/save_watchlist.dart';
import 'package:core/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'tv_watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTV,
  TVGetWatchListStatus,
  TVSaveWatchlist,
  TVRemoveWatchlist,
])
void main() {
  late TVWatchlistCubit cubit;
  late MockGetTVWatchlist mockGetWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetTVWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = TVWatchlistCubit(
      watchlist: mockGetWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  const ttvDetail = TVDetail(
    backdrop_path: 'backdrop_path',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    original_name: 'original_name',
    overview: 'overview',
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final ttv = Tv(
    backdrop_path: '/mC32mlq894Lho4zXK6NUKnZcRgF.jpg',
    genreIds: const [18],
    id: 1,
    original_name: 'Major Crimes',
    overview: 'overview',
    popularity: 8.724475,
    poster_path: 'poster_path',
    first_air_date: '2012-08-13',
    name: 'name',
    voteAverage: 6.5,
    voteCount: 17,
  );

  final ttvList = [ttv];
  group('Get Watchlist', () {
    test('should emit initial state', () {
      expect(cubit.state, WatchlistInitial());
    });
  });
  blocTest<TVWatchlistCubit, TVWatchlistState>(
    'should execute watchlist when function is called',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer((_) async => Right(ttvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlist(),
    verify: (cubit) => mockGetWatchlist.execute(),
  );
  blocTest<TVWatchlistCubit, TVWatchlistState>(
    'Should emit [Loading, Loaded] when tv data is gotten successfully',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer((_) async => Right(ttvList));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlist(),
    expect: () => [
      WatchlistLoading(),
      WatchlistLoaded(ttvList),
    ],
    verify: (cubit) => mockGetWatchlist.execute(),
  );
  blocTest<TVWatchlistCubit, TVWatchlistState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure('Can\'t get data')));
      return cubit;
    },
    act: (cubit) => cubit.fetchWatchlist(),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError('Can\'t get data'),
    ],
    verify: (cubit) => mockGetWatchlist.execute(),
  );

  group('Watchlist status', () {
    blocTest<TVWatchlistCubit, TVWatchlistState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchListStatus.execute(ttv.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.loadWatchlistStatus(ttv.id),
      expect: () => [const WatchlistStatus(true)],
    );
  });

  group('Save Watchlist', () {
    blocTest<TVWatchlistCubit, TVWatchlistState>(
      'should execute save watchlist when function is called',
      build: () {
        when(mockSaveWatchlist.execute(ttvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(ttv.id))
            .thenAnswer((_) async => true);

        return cubit;
      },
      act: (cubit) => cubit.addWatchlist(ttvDetail),
      verify: (cubit) => mockSaveWatchlist.execute(ttvDetail),
    );
    group('tv', () {
      blocTest<TVWatchlistCubit, TVWatchlistState>(
        'should update watchlist message when add watchlist success',
        build: () {
          when(mockGetWatchListStatus.execute(ttv.id))
              .thenAnswer((_) async => true);
          when(mockSaveWatchlist.execute(ttvDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));

          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(ttvDetail),
        expect: () => [
          const WatchlistMessage('Added to Watchlist'),
          const WatchlistStatus(true),
        ],
        verify: (cubit) => mockSaveWatchlist.execute(ttvDetail),
      );
      blocTest<TVWatchlistCubit, TVWatchlistState>(
        'should update watchlist message when add watchlist failed',
        build: () {
          when(mockGetWatchListStatus.execute(ttv.id))
              .thenAnswer((_) async => false);
          when(mockSaveWatchlist.execute(ttvDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));

          return cubit;
        },
        act: (cubit) => cubit.addWatchlist(ttvDetail),
        expect: () => [
          const WatchlistMessage('Failed'),
          const WatchlistStatus(false),
        ],
        verify: (cubit) => mockSaveWatchlist.execute(ttvDetail),
      );
    });

    group('Remove Watchlist', () {
      blocTest<TVWatchlistCubit, TVWatchlistState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(ttvDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          when(mockGetWatchListStatus.execute(ttvDetail.id))
              .thenAnswer((_) async => false);

          return cubit;
        },
        act: (cubit) => cubit.deleteWatchlist(ttvDetail),
        verify: (cubit) => verify(mockRemoveWatchlist.execute(ttvDetail)),
      );

      group('tv', () {
        blocTest<TVWatchlistCubit, TVWatchlistState>(
          'should update watchlist message when remove watchlist success',
          build: () {
            when(mockRemoveWatchlist.execute(ttvDetail))
                .thenAnswer((_) async => const Right('Removed from Watchlist'));
            when(mockGetWatchListStatus.execute(ttvDetail.id))
                .thenAnswer((_) async => false);

            return cubit;
          },
          act: (cubit) => cubit.deleteWatchlist(ttvDetail),
          expect: () => [
            const WatchlistMessage('Removed from Watchlist'),
            const WatchlistStatus(false),
          ],
          verify: (cubit) {
            verify(mockRemoveWatchlist.execute(ttvDetail));
            verify(mockGetWatchListStatus.execute(ttvDetail.id));
          },
        );

        blocTest<TVWatchlistCubit, TVWatchlistState>(
          'should update watchlist message when Removed from Watchlist failed',
          build: () {
            when(mockRemoveWatchlist.execute(ttvDetail))
                .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
            when(mockGetWatchListStatus.execute(ttvDetail.id))
                .thenAnswer((_) async => false);

            return cubit;
          },
          act: (cubit) => cubit.deleteWatchlist(ttvDetail),
          expect: () => [
            const WatchlistMessage('Failed'),
            const WatchlistStatus(false),
          ],
          verify: (cubit) {
            verify(mockRemoveWatchlist.execute(ttvDetail));
            verify(mockGetWatchListStatus.execute(ttvDetail.id));
          },
        );
      });
    });
  });
}
