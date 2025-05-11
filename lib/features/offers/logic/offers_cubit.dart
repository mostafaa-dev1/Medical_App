import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:medical_system/features/offers/data/data_services/offers_data.dart';
import 'package:medical_system/features/offers/data/model/offers_model.dart';
import 'package:meta/meta.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());
  final _offersData = OffersData();
  List<OffersModel>? offers;
  Future<void> getOffers(String provider) async {
    emit(GetOffersLoading());
    final result = await _offersData.getOffers(provider: provider);
    result.fold((l) {
      emit(GetOffersError(errMessage: l));
    }, (r) {
      log(r.toString());
      offers = r.map((e) => OffersModel.fromJson(e)).toList();
      emit(GetOffersSuccess());
    });
  }
}
