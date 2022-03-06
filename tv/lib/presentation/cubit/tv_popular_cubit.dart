import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
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
