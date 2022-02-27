import 'package:aplikasiditonton/domain/entities/tv/tv.dart';
import 'package:aplikasiditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'tv_popular_state.dart';

class TVPopularCubit extends Cubit<TVPopularState> {
  final GetPopularTV popularTV;

  TVPopularCubit({required this.popularTV}) : super(TVPopularInitial());

  void fetchPopularTv() async {
    emit(TVPopularLoading());

    final result = await popularTV.execute();

    result.fold(
      (failure) async => emit(TVPopularError(failure.message)),
      (data) async => emit(TVPopularLoaded(data)),
    );
  }
}
