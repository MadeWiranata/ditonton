// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects.dart';
import '../../../helpers/tv/test_helper.mocks.dart';

void main() {
  late TVSaveWatchlist usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = TVSaveWatchlist(mockTVRepository);
  });

  test('should save tv to the repository', () async {
    // arrange
    when(mockTVRepository.saveWatchlist(testTVDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    verify(mockTVRepository.saveWatchlist(testTVDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
