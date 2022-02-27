// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  Tv({
    required this.backdrop_path,
    required this.genreIds,
    required this.id,
    required this.original_name,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.first_air_date,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.poster_path,
    required this.name,
  });

  bool? adult;
  String? backdrop_path;
  List<int>? genreIds;
  int id;
  String? original_name;
  String? overview;
  double? popularity;
  String? poster_path;
  String? first_air_date;
  String? name;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdrop_path,
        genreIds,
        id,
        original_name,
        overview,
        popularity,
        poster_path,
        first_air_date,
        name,
        voteAverage,
        voteCount,
      ];
}
