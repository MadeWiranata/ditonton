import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
