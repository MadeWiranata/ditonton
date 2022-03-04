import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTV {
  final TVRepository _repository;

  GetWatchlistTV(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTV();
  }
}
