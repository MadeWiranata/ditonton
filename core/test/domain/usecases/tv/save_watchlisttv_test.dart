// ignore_for_file: prefer_const_constructors

import 'package:core/domain/usecases/tv/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../../tv/test/dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

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
