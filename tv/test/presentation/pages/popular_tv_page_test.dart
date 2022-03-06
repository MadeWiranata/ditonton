import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/cubit/tv_popular_cubit.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import '../../../../tv/test/dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([TVPopularCubit])
void main() {
  late MockTVPopularCubit mockCubit;

  setUp(() {
    mockCubit = MockTVPopularCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVPopularCubit>.value(
      value: mockCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockCubit.stream).thenAnswer((_) => Stream.value(TVPopularLoading()));
    when(mockCubit.state).thenReturn(TVPopularLoading());

    final loadingWidget = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(loadingWidget, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(TVPopularLoaded(testTVList)));
    when(mockCubit.state).thenReturn(TVPopularLoaded(testTVList));

    final listViewWidget = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(listViewWidget, findsOneWidget);
  });

  testWidgets('Page should display error message when Error',
      (WidgetTester tester) async {
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.value(const TVPopularError('Error Message')));
    when(mockCubit.state).thenReturn(const TVPopularError('Error Message'));

    final textWidget = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVPage()));

    expect(textWidget, findsOneWidget);
  });
}
