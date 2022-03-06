import 'package:core/utils/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'tv_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late TVTopRatedCubit cubit;
  late MockGetTopRatedTV mockGetTopRatedTV;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
    cubit = TVTopRatedCubit(
      topRatedTV: mockGetTopRatedTV,
    );
  });

  group('Top Rated', () {
    test('should emit initial state', () {
      expect(cubit.state, TVTopRatedInitial());
    });
    blocTest<TVTopRatedCubit, TVTopRatedState>(
      'Should execute top rated list when function is called',
      build: () {
        when(mockGetTopRatedTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      verify: (cubit) => mockGetTopRatedTV.execute(),
    );
    blocTest<TVTopRatedCubit, TVTopRatedState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      expect: () => [
        TVTopRatedLoading(),
        TVTopRatedLoaded(testTVList),
      ],
      verify: (cubit) => mockGetTopRatedTV.execute(),
    );
    blocTest<TVTopRatedCubit, TVTopRatedState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTV.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTv(),
      expect: () => [
        TVTopRatedLoading(),
        const TVTopRatedError('Server Failure'),
      ],
      verify: (cubit) => mockGetTopRatedTV.execute(),
    );
  });
}
