import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';

class TVRemoveWatchlist {
  final TVRepository repository;

  TVRemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeWatchlist(tv);
  }
}
