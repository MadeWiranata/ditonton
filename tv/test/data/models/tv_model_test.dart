// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  final tTvModel = TVModel(
    backdrop_path: 'backdrop_path',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'original_name',
    overview: 'overview',
    popularity: 1,
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = Tv(
    backdrop_path: 'backdrop_path',
    genreIds: [1, 2, 3],
    id: 1,
    original_name: 'original_name',
    overview: 'overview',
    popularity: 1,
    poster_path: 'poster_path',
    first_air_date: 'first_air_date',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of TV entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
