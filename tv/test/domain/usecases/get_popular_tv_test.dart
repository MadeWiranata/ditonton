import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTV usecase;
  late MockTVRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTVRepository();
    usecase = GetPopularTV(mockTVRpository);
  });

  final tTV = <Tv>[];

  group('GetPopularTV Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.getPopularTV())
            .thenAnswer((_) async => Right(tTV));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTV));
      });
    });
  });
}
