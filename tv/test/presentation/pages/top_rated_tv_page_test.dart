import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/tv_top_rated_cubit.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TVTopRatedCubit])
void main() {
  late MockTVTopRatedCubit mockCubit;

  setUp(() {
    mockCubit = MockTVTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVTopRatedCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(TVTopRatedLoading()));
    when(mockCubit.state).thenReturn(TVTopRatedLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(TVTopRatedLoaded(testTVList)));
    when(mockCubit.state).thenReturn(TVTopRatedLoaded(testTVList));

    final listViewWidget = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTVPage()));

    expect(listViewWidget, findsOneWidget);
  });

  testWidgets('Page should display error message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const TVTopRatedError('Error Message')));
    when(mockCubit.state).thenReturn(const TVTopRatedError('Error Message'));

    final textWidget = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTVPage()));

    expect(textWidget, findsOneWidget);
  });
}
