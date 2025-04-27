import 'package:bloc/bloc.dart';
import 'package:medical_system/features/home/data/models/spcilailties_model.dart';
import 'package:medical_system/features/spcialities/data/data_services/specilalties_data.dart';
import 'package:meta/meta.dart';

part 'spcialities_state.dart';

class SpcialtiesCubit extends Cubit<SpcialtiesState> {
  SpcialtiesCubit() : super(SpcialtiesInitial());

  final _spcialitiesData = SpecilaltiesData();

  SpcilailtiesList specialities = SpcilailtiesList();
  Future<void> getSpecialities({
    required String type,
  }) async {
    emit(GetSpecialitiesLoading());
    final response = await _spcialitiesData.getSpecialities(type: type);
    response.fold((error) {
      emit(GetSpecialitiesFailure(error: error));
    }, (data) {
      specialities = SpcilailtiesList.fromJson(data);
      emit(GetSpecialitiesSuccess());
    });
  }
}
