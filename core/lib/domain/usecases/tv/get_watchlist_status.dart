import 'package:tv/domain/repositories/tv_repository.dart';

class TVGetWatchListStatus {
  final TVRepository repository;

  TVGetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
