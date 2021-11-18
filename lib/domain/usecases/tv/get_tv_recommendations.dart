import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/repositories/tv/tv_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';

class GetTVRecommendations {
  final TVRepository repository;

  GetTVRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTVRecommendations(id);
  }
}
