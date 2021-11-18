import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
