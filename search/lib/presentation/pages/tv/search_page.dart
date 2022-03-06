import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/widget/tv_card_list.dart';

class SearchPageTV extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-tv';

  const SearchPageTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('query_input'),
              onChanged: (query) {
                context.read<SearchTVBloc>().add(OnChangeTvQuery(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVBloc, SearchTVState>(
              builder: (context, state) {
                if (state is SearchTVLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTVHasData) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return TVCard(
                          state.result[index],
                        );
                      },
                      itemCount: state.result.length,
                    ),
                  );
                } else if (state is SearchTVError) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      key: Key('error_message'),
                      child: Text(
                        'Search Not Found',
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
