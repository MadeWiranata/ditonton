import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetNowPlayingTV(mockTVRepository);
  });

  final tTV = <Tv>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.getNowPlayingTV())
        .thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTV));
  });
}
