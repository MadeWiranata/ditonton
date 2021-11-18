import 'package:dartz/dartz.dart';
import 'package:aplikasiditonton/common/failure.dart';
import 'package:aplikasiditonton/domain/entities/movie_detail.dart';
import 'package:aplikasiditonton/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
