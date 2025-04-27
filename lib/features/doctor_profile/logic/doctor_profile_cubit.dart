import 'package:bloc/bloc.dart';
import 'package:medical_system/core/models/reviews.dart';
import 'package:medical_system/features/doctor_profile/data/data_services/doctor_profile_data.dart';
import 'package:meta/meta.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial());
  final _data = DoctorProfileData();

  Reviews reviews = Reviews(reviews: []);
  Future<void> getReviews(String doctorId, int? limit) async {
    emit(GetReviewsLoading());
    final response = await _data.getReviews(doctorId: doctorId, limit: limit);
    response.fold((l) {
      emit(GetReviewsError(l));
    }, (r) {
      reviews = Reviews.fromJson(r);
      emit(GetReviewsSuccess());
    });
  }
}
