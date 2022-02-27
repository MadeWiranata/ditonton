part of 'tv_detail_cubit.dart';

@immutable
abstract class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object?> get props => [];
}

class TVDetailInitial extends TVDetailState {}

class TVDetailLoading extends TVDetailState {}

class TVDetailLoaded extends TVDetailState {
  final TVDetail tvDetail;
  final List<Tv> recommendationTv;

  const TVDetailLoaded(
    this.tvDetail,
    this.recommendationTv,
  );

  @override
  List<Object?> get props => [
        TVDetail,
        recommendationTv,
      ];
}

class TVDetailError extends TVDetailState {
  final String message;

  const TVDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class TVRecommendationLoading extends TVDetailState {}

class TVRecommendationError extends TVDetailState {
  final String message;

  const TVRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}
