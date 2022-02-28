import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tvwatchlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:aplikasiditonton/presentation/cubit/tv/tv_detail_cubit.dart';
import 'package:aplikasiditonton/presentation/pages/tv/tv_detail_page.dart';
import '../../../dummy_data/tv/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([
  TVDetailCubit,
  TVWatchlistCubit,
])
void main() {
  late MockTVDetailCubit mockTVDetailCubit;
  late MockWatchlistCubit mockWatchlistCubit;

  setUp(() {
    mockTVDetailCubit = MockTVDetailCubit();
    mockWatchlistCubit = MockWatchlistCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailCubit>.value(
      value: mockTVDetailCubit,
      child: BlocProvider<TVWatchlistCubit>.value(
        value: mockWatchlistCubit,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
    'should display proggress bar when movie and recommendation loading',
    (WidgetTester tester) async {
      when(mockTVDetailCubit.stream)
          .thenAnswer((_) => Stream.value(TVDetailLoading()));
      when(mockTVDetailCubit.state).thenReturn(TVDetailLoading());
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(WatchlistInitial()));
      when(mockWatchlistCubit.state).thenReturn(WatchlistInitial());

      final loadingFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));
      expect(loadingFinder, findsOneWidget);
    },
  );
  testWidgets(
    'should display error message when get data is error',
    (WidgetTester tester) async {
      when(mockTVDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const TVDetailError('Error Message')));
      when(mockTVDetailCubit.state)
          .thenReturn(const TVDetailError('Error Message'));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(WatchlistInitial()));
      when(mockWatchlistCubit.state).thenReturn(WatchlistInitial());

      final errorFinder = find.text('Error Message');

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv series not added to watchlist",
    (WidgetTester tester) async {
      when(mockTVDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
      when(mockTVDetailCubit.state)
          .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
      when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display check icon when tv series added to watchlist",
    (WidgetTester tester) async {
      when(mockTVDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
      when(mockTVDetailCubit.state)
          .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
      when(mockWatchlistCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
      when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTVDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
    when(mockTVDetailCubit.state)
        .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
    when(mockWatchlistCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMessage('Added to Watchlist')));
    when(mockWatchlistCubit.state)
        .thenReturn(const WatchlistMessage('Added to Watchlist'));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockTVDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
    when(mockTVDetailCubit.state)
        .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
    when(mockWatchlistCubit.stream).thenAnswer(
        (_) => Stream.value(const WatchlistMessage('Removed from Watchlist')));
    when(mockWatchlistCubit.state)
        .thenReturn(const WatchlistMessage('Removed from Watchlist'));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTVDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
    when(mockTVDetailCubit.state)
        .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(false)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(false));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMessage('Failed')));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when removed from watchlist failed',
      (WidgetTester tester) async {
    when(mockTVDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const TVDetailLoaded(testTVDetail, <Tv>[])));
    when(mockTVDetailCubit.state)
        .thenReturn(const TVDetailLoaded(testTVDetail, <Tv>[]));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistStatus(true)));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistStatus(true));
    when(mockWatchlistCubit.stream)
        .thenAnswer((_) => Stream.value(const WatchlistMessage('Failed')));
    when(mockWatchlistCubit.state).thenReturn(const WatchlistMessage('Failed'));

    await tester.pumpWidget(_makeTestableWidget(const TVDetailPage(id: 1)));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
