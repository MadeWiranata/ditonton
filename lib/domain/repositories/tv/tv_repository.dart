import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TVRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingTV();
  Future<Either<Failure, List<Tv>>> getPopularTV();
  Future<Either<Failure, List<Tv>>> getTopRatedTV();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<Tv>>> getTVRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTV(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TVDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTV();
}
