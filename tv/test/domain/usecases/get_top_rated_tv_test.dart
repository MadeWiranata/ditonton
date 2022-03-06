import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTopRatedTV(mockTVRepository);
  });

  final tTV = <Tv>[];

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTVRepository.getTopRatedTV()).thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTV));
  });
}
