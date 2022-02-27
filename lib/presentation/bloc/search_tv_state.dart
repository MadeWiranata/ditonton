import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTVState extends Equatable {
  const SearchTVState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTVState {}

class SearchLoading extends SearchTVState {}

class SearchError extends SearchTVState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTVState {
  final List<Tv> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
