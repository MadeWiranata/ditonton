// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';

class TVModel extends Equatable {
  const TVModel({
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

  final String? backdrop_path;
  final List<int> genreIds;
  final int id;
  final String original_name;
  final String? overview;
  final double popularity;
  final String? poster_path;
  final String? first_air_date;
  final String name;
  final double voteAverage;
  final int voteCount;

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
        backdrop_path: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        original_name: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        poster_path: json["poster_path"],
        first_air_date: json["first_air_date"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdrop_path,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_name": original_name,
        "overview": overview,
        "popularity": popularity,
        "poster_path": poster_path,
        "first_air_date": first_air_date,
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Tv toEntity() {
    return Tv(
      backdrop_path: backdrop_path,
      genreIds: genreIds,
      id: id,
      original_name: original_name,
      overview: overview,
      popularity: popularity,
      poster_path: poster_path,
      first_air_date: first_air_date,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

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
