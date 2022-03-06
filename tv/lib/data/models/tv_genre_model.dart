// ignore_for_file: unnecessary_this

import 'package:core/domain/entities/tv/genre.dart';
import 'package:equatable/equatable.dart';

class TVGenreModel extends Equatable {
  const TVGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TVGenreModel.fromJson(Map<String, dynamic> json) => TVGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  Genre toEntity() {
    return Genre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
