import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

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
