import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/features/write_review/data/write_review_data/write_review_data.dart';

part 'write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  WriteReviewCubit() : super(WriteReviewInitial());
  final _writeReviewData = WriteReviewData();

  TextEditingController reviewController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double currentRate = 0.0;
  int currentCount = 0;
  double userRate = 0.0;
  Future<void> getClinicRate({
    required String clinicId,
    required String userId,
    required String doctorId,
  }) async {
    emit(WriteReviewLoading());
    final response = await _writeReviewData.getClinicRate(clinicId: clinicId);
    response.fold((error) {
      emit(WriteReviewError(error));
    }, (data) async {
      print(data);
      currentRate = data[0]['rate'].toDouble() ?? 0.0;
      currentCount = data[0]['rate_count'] ?? 0;
      await sendClinicRate(
        clinicId: clinicId,
      );
      await sendReview(
          review: reviewController.text,
          rate: userRate,
          userId: userId,
          doctorId: doctorId);
      emit(WriteReviewSuccess());
    });
  }

  Future<void> sendReview({
    required String review,
    required double rate,
    required String userId,
    required String doctorId,
  }) async {
    final response = await _writeReviewData.sendReview(
        review: review, rate: rate, userId: userId, doctorId: doctorId);
    response.fold((error) {
      emit(WriteReviewError(error));
    }, (data) {});
  }

  Future<void> sendClinicRate({
    required String clinicId,
  }) async {
    final int newCount = currentCount + 1;
    final double newRate = ((currentRate * currentCount) + userRate) / newCount;
    final response = await _writeReviewData.sendClinicRate(
        clinicId: clinicId, rate: newRate, rateCount: newCount);
    response.fold((error) {
      emit(WriteReviewError(error));
    }, (data) {});
  }
}
