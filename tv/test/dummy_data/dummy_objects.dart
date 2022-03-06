// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:core/domain/entities/genre.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTV = Tv(
  backdrop_path: '/mC32mlq894Lho4zXK6NUKnZcRgF.jpg',
  genreIds: [18],
  id: 39483,
  original_name: 'Major Crimes',
  overview:
      'Major Crimes explores how the American justice system approaches the art of the deals as law enforcement officers and prosecutors work together to score a conviction. Los Angeles Police Captain Sharon Raydor heads up a special squad within the LAPD that deals with high-profile or particularly sensitive crimes.',
  popularity: 8.724475,
  poster_path: '/4kUtFpFb2WsdiH4kqZwoNvodMRZ.jpg',
  first_air_date: '2012-08-13',
  name: 'Major Crimes',
  voteAverage: 6.5,
  voteCount: 17,
);

final testTVList = [testTV];

const testTVDetail = TVDetail(
  backdrop_path: 'backdrop_path',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  original_name: 'original_name',
  overview: 'overview',
  poster_path: 'poster_path',
  first_air_date: 'first_air_date',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTV = Tv.watchlist(
  id: 1,
  name: 'name',
  poster_path: 'poster_path',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'name',
  poster_path: 'poster_path',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'poster_path': 'poster_path',
};
