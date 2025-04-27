part of 'write_review_cubit.dart';

@immutable
sealed class WriteReviewState {}

final class WriteReviewInitial extends WriteReviewState {}

final class WriteReviewLoading extends WriteReviewState {}

final class WriteReviewSuccess extends WriteReviewState {}

final class WriteReviewError extends WriteReviewState {
  final String error;
  WriteReviewError(this.error);
}
