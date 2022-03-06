import 'package:core/utils/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/cubit/tv_detail_cubit.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
])
void main() {
  late TVDetailCubit cubit;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;

  setUp(() {
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetTVDetail = MockGetTVDetail();
    cubit = TVDetailCubit(
      tvDetail: mockGetTVDetail,
      tvRecommendations: mockGetTVRecommendations,
    );
  });

  group('Get Tv Series Detail and Recommendation Tv Series', () {
    test('initial state should be empty', () {
      expect(cubit.state, TVDetailInitial());
    });
    blocTest<TVDetailCubit, TVDetailState>(
      'should execute tv detail when function called',
      build: () {
        when(mockGetTVDetail.execute(testTV.id))
            .thenAnswer((_) async => const Right(testTVDetail));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTV.id),
      verify: (cubit) => mockGetTVDetail.execute(testTV.id),
    );
    blocTest<TVDetailCubit, TVDetailState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(testTV.id))
            .thenAnswer((_) async => const Right(testTVDetail));
        when(mockGetTVRecommendations.execute(testTV.id))
            .thenAnswer((_) async => Right(testTVList));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTV.id),
      expect: () => [
        TVDetailLoading(),
        TVRecommendationLoading(),
        TVDetailLoaded(
          testTVDetail,
          testTVList,
        ),
      ],
      verify: (cubit) {
        mockGetTVDetail.execute(testTV.id);
        mockGetTVRecommendations.execute(testTV.id);
      },
    );
    blocTest<TVDetailCubit, TVDetailState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(testTV.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        when(mockGetTVRecommendations.execute(testTV.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTV.id),
      expect: () => [
        TVDetailLoading(),
        const TVDetailError('Server Failure'),
      ],
      verify: (cubit) {
        mockGetTVDetail.execute(testTV.id);
        mockGetTVRecommendations.execute(testTV.id);
      },
    );
    blocTest<TVDetailCubit, TVDetailState>(
      'Should emit [Loading, Error] when recommendation is gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(testTV.id))
            .thenAnswer((_) async => const Right(testTVDetail));
        when(mockGetTVRecommendations.execute(testTV.id)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));

        return cubit;
      },
      act: (cubit) => cubit.fetchDetailTv(testTV.id),
      expect: () => [
        TVDetailLoading(),
        TVRecommendationLoading(),
        const TVRecommendationError('Server Failure'),
      ],
      verify: (cubit) {
        mockGetTVDetail.execute(testTV.id);
        mockGetTVRecommendations.execute(testTV.id);
      },
    );
  });
}
