import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/search_tv.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_event.dart';
import 'package:aplikasiditonton/presentation/bloc/search_tv_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late SearchTVBloc searchTVBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchTVBloc = SearchTVBloc(mockSearchTV);
  });
  test('initial state should be empty', () {
    expect(searchTVBloc.state, SearchEmpty());
  });
  final tTVModel = Tv(
    backdrop_path: '/mC32mlq894Lho4zXK6NUKnZcRgF.jpg',
    genreIds: [18],
    id: 557,
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
  final tTVList = <Tv>[tTVModel];
  final tQuery = 'Major Crimes';

  blocTest<SearchTVBloc, SearchTVState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      return searchTVBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
}
