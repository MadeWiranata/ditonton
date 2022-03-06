import 'package:core/utils/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/cubit/tv_now_playing_cubit.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'tv_now_playing_cubit_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTV,
])
void main() {
  late TVNowPlayingCubit cubit;
  late MockGetNowPlayingTV mockGetNowPlayingTV;

  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTV();
    cubit = TVNowPlayingCubit(
      nowPlayingTV: mockGetNowPlayingTV,
    );
  });

  group('Now playing', () {
    test('should emit initial state', () {
      expect(cubit.state, TVNowPlayingInitial());
    });
    blocTest<TVNowPlayingCubit, TVNowPlayingState>(
      'Should execute now playing list when function is called',
      build: () {
        when(mockGetNowPlayingTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      verify: (cubit) => mockGetNowPlayingTV.execute(),
    );
    blocTest<TVNowPlayingCubit, TVNowPlayingState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      expect: () => [
        TVNowPlayingLoading(),
        TVNowPlayingLoaded(testTVList),
      ],
      verify: (cubit) => mockGetNowPlayingTV.execute(),
    );
    blocTest<TVNowPlayingCubit, TVNowPlayingState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTV.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingTv(),
      expect: () => [
        TVNowPlayingLoading(),
        const TVNowPlayingError('Server Failure'),
      ],
      verify: (cubit) => mockGetNowPlayingTV.execute(),
    );
  });
}
