import 'package:aplikasiditonton/data/models/tv/tv_table.dart';
import 'package:aplikasiditonton/domain/entities/tv/genre.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/entities/tv/tv_detail.dart';

final testTV = Tv(
  backdrop_path: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  original_name: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  poster_path: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  first_air_date: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTVList = [testTV];

final testTVDetail = TVDetail(
  backdrop_path: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  original_name: 'originalTitle',
  overview: 'overview',
  poster_path: 'posterPath',
  first_air_date: 'releaseDate',
  name: '120',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTV = Tv.watchlist(
  id: 1,
  name: 'title',
  poster_path: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'title',
  poster_path: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
