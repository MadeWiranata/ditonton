import 'package:equatable/equatable.dart';

abstract class SearchTVEvent extends Equatable {
  const SearchTVEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchTVEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
