import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
part 'tv_top_rated_state.dart';

class TVTopRatedCubit extends Cubit<TVTopRatedState> {
  final GetTopRatedTV topRatedTV;

  TVTopRatedCubit({required this.topRatedTV}) : super(TVTopRatedInitial());

  void fetchTopRatedTv() async {
    emit(TVTopRatedLoading());

    final result = await topRatedTV.execute();

    result.fold(
      (failure) async => emit(TVTopRatedError(failure.message)),
      (data) async => emit(TVTopRatedLoaded(data)),
    );
  }
}
