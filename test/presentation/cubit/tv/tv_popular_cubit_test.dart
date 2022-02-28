import 'package:bloc_test/bloc_test.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_popular_cubit.dart';
import 'tv_popular_cubit_test.mocks.dart';
import '../../../dummy_data/tv/dummy_objects.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late TVPopularCubit cubit;
  late MockGetPopularTV mockGetPopularTV;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    cubit = TVPopularCubit(
      popularTV: mockGetPopularTV,
    );
  });

  group('Popular', () {
    test('should emit initial state', () {
      expect(cubit.state, TVPopularInitial());
    });
    blocTest<TVPopularCubit, TVPopularState>(
      'Should execute popular list when function is called',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      verify: (cubit) => mockGetPopularTV.execute(),
    );
    blocTest<TVPopularCubit, TVPopularState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTV.execute())
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      expect: () => [
        TVPopularLoading(),
        TVPopularLoaded(testTVList),
      ],
      verify: (cubit) => mockGetPopularTV.execute(),
    );
    blocTest<TVPopularCubit, TVPopularState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetPopularTV.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTv(),
      expect: () => [
        TVPopularLoading(),
        const TVPopularError('Server Failure'),
      ],
      verify: (cubit) => mockGetPopularTV.execute(),
    );
  });
}
