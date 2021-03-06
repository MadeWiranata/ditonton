import 'package:core/domain/usecases/tv/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late TVGetWatchListStatus usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = TVGetWatchListStatus(mockTVRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
