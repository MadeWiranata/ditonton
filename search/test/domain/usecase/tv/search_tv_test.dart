// ignore_for_file: prefer_const_declarations

import 'package:search/domain/usecases/tv/search_tv.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tTV = <Tv>[];
  final tQuery = 'Major Crimes';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTV(tQuery)).thenAnswer((_) async => Right(tTV));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTV));
  });
}
