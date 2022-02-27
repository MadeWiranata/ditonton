// ignore_for_file: non_constant_identifier_names

import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TVTable extends Equatable {
  final int id;
  final String? name;
  final String? poster_path;
  final String? overview;

  const TVTable({
    required this.id,
    required this.name,
    required this.poster_path,
    required this.overview,
  });

  factory TVTable.fromEntity(TVDetail tv) => TVTable(
        id: tv.id,
        name: tv.name,
        poster_path: tv.poster_path,
        overview: tv.overview,
      );

  factory TVTable.fromMap(Map<String, dynamic> map) => TVTable(
        id: map['id'],
        name: map['name'],
        poster_path: map['poster_path'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'poster_path': poster_path,
        'overview': overview,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        poster_path: poster_path,
        name: name,
      );

  @override
  // ignore: todo
  // TODO: implement props
  List<Object?> get props => [id, name, poster_path, overview];
}
