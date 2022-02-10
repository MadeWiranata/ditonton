import 'dart:convert';

import 'package:aplikasiditonton/data/models/tv/tv_model.dart';
import 'package:aplikasiditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdrop_path: "/path.jpg",
    genreIds: [18, 9648],
    id: 1,
    original_name: "Pretty Little Liars",
    overview: "Overview",
    popularity: 1.0,
    poster_path: "/path.jpg",
    first_air_date: "2020-05-05",
    name: "Pretty Little Liars",
    voteAverage: 5.04,
    voteCount: 133,
  );
  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/on_the_air.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'backdrop_path': '/path.jpg',
            'genre_ids': [18, 9648],
            'id': 1,
            'original_name': 'Pretty Little Liars',
            'overview': 'Overview',
            'popularity': 1.0,
            'poster_path': '/path.jpg',
            'first_air_date': '2020-05-05',
            'name': 'Pretty Little Liars',
            'vote_average': 5.04,
            'vote_count': 133
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
