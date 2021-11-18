import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';

class GetNowPlayingTV {
  final TVRepository repository;

  GetNowPlayingTV(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTV();
  }
}
