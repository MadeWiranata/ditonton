// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_genre_model.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class TVDetailResponse extends Equatable {
  const TVDetailResponse({
    required this.backdrop_path,
    required this.first_air_date,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.in_production,
    required this.last_air_date,
    required this.name,
    required this.number_of_episodes,
    required this.number_of_seasons,
    required this.original_name,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdrop_path;
  final String first_air_date;
  final List<TVGenreModel> genres;
  final String? homepage;
  final int id;
  final bool in_production;
  final String last_air_date;
  final String name;
  final int? number_of_episodes;
  final int? number_of_seasons;
  final String original_name;
  final String overview;
  final double popularity;
  final String poster_path;
  final String? status;
  final String? tagline;
  final String? type;
  final double voteAverage;
  final int voteCount;

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVDetailResponse(
        backdrop_path: json["backdrop_path"],
        first_air_date: json["first_air_date"],
        genres: List<TVGenreModel>.from(
            json["genres"].map((x) => TVGenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        in_production: json["in_production"],
        last_air_date: json["last_air_date"],
        name: json["name"],
        number_of_episodes: json["number_of_episodes"],
        number_of_seasons: json["number_of_seasons"],
        original_name: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        poster_path: json["poster_path"],
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdrop_path,
        "first_air_date": first_air_date,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": in_production,
        "last_air_date": last_air_date,
        "name": name,
        "number_of_episodes": number_of_episodes,
        "number_of_seasons": number_of_seasons,
        "original_name": original_name,
        "overview": overview,
        "popularity": popularity,
        "poster_path": poster_path,
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVDetail toEntity() {
    return TVDetail(
      backdrop_path: backdrop_path,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      original_name: original_name,
      overview: overview,
      poster_path: poster_path,
      first_air_date: first_air_date,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object?> get props => [
        backdrop_path,
        first_air_date,
        genres,
        homepage,
        id,
        in_production,
        last_air_date,
        name,
        number_of_episodes,
        number_of_seasons,
        original_name,
        overview,
        popularity,
        poster_path,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
