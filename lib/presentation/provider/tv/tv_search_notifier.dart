import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/search_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';

class TVSearchNotifier extends ChangeNotifier {
  final SearchTV searchTV;

  TVSearchNotifier({required this.searchTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTV.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
