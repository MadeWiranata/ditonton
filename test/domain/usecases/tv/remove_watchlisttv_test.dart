// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/tv/test_helper.mocks.dart';

void main() {
  late TVRemoveWatchlist usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = TVRemoveWatchlist(mockTVRepository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTVRepository.removeWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.removeWatchlist(testTVDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
