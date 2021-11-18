import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';

class GetWatchListStatus {
  final TVRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
