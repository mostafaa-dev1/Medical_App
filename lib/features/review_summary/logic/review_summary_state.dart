part of 'review_summary_cubit.dart';

@immutable
sealed class ReviewSummaryState {}

final class ReviewSummaryInitial extends ReviewSummaryState {}

final class ChangePaymentIndex extends ReviewSummaryState {}

final class BookAppointmentLoading extends ReviewSummaryState {}

final class BookAppointmentSuccess extends ReviewSummaryState {}

final class BookAppointmentError extends ReviewSummaryState {
  final String message;

  BookAppointmentError(this.message);
}

final class PayWithCardLoading extends ReviewSummaryState {}

final class PayWithCardSuccess extends ReviewSummaryState {
  final String paymentKey;

  PayWithCardSuccess(this.paymentKey);
}

final class PayWithCardError extends ReviewSummaryState {
  final String message;

  PayWithCardError(this.message);
}

final class DiscountLoadnig extends ReviewSummaryState {}

final class DiscountSuccess extends ReviewSummaryState {}

final class DiscountError extends ReviewSummaryState {
  final String message;

  DiscountError(this.message);
}

final class NoInternetConnection extends ReviewSummaryState {
  final String error;

  NoInternetConnection(this.error);
}
