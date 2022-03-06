import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/entities/movie.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
