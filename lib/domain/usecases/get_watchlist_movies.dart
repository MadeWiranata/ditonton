import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';
import 'package:aplikasiditonton/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
