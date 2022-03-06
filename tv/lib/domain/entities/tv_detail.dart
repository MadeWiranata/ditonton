// ignore_for_file: non_constant_identifier_names

import 'package:core/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVDetail extends Equatable {
  const TVDetail({
    required this.backdrop_path,
    required this.genres,
    required this.id,
    required this.original_name,
    required this.overview,
    required this.poster_path,
    required this.first_air_date,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdrop_path;
  final List<Genre> genres;
  final int id;
  final String original_name;
  final String overview;
  final String? poster_path;
  final String? first_air_date;
  final String name;
  final double voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdrop_path,
        genres,
        id,
        original_name,
        overview,
        poster_path,
        first_air_date,
        name,
        voteAverage,
        voteCount,
      ];
}
