import 'package:aplikasiditonton/domain/entities/movie.dart';
import 'package:aplikasiditonton/domain/usecases/search_movies.dart';
import 'package:aplikasiditonton/presentation/bloc/search_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../provider/movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies searchMovies;

  setUp(() {
    searchMovies = MockSearchMovies();
    searchBloc = SearchBloc(
      searchMovies: searchMovies,
    );
  });

  test('should emit initial state', () {
    expect(searchBloc.state, SearchMoviesInitial());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(searchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnChangeMovieQuery(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesHasData(tMovieList),
    ],
    verify: (bloc) => searchMovies.execute(tQuery),
  );
  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, Error] when data is failed',
    build: () {
      when(searchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnChangeMovieQuery(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchMoviesLoading(),
      const SearchMoviesError(''),
    ],
    verify: (bloc) => searchMovies.execute(tQuery),
  );
}
