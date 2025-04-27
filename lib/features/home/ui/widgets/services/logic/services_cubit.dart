import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_system/core/networking/connectivity/connectivity_helper.dart';
import 'package:medical_system/core/networking/services/database/remote/firebase_services.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/find_medicine.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/models/question_model.dart';
import 'package:medical_system/features/home/ui/widgets/services/data/services_data/services_data.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
  final _servicesData = ServicesData();

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController questionDetailsController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? speciality;
  String? gender;
  String? imageUrl;
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicineNotesController = TextEditingController();

  final findMedicineKey = GlobalKey<FormState>();
  final questionKey = GlobalKey<FormState>();

  Future<void> findMedicine(String userID) async {
    if (!await ConnectivityHelper.checkConnection()) {
      emit(NoInternetConnection('No internet connection'));
      return;
    }
    emit(ServicesLoading());

    if (pickedImage != null) {
      await uploadImage();
    }
    log(imageUrl.toString());
    FindMedicineModel findMedicine = FindMedicineModel(
      name: medicineNameController.text,
      notes: medicineNotesController.text,
      image: imageUrl,
      isFound: false,
      userId: userID,
    );
    final result = await _servicesData.findMedicine(findMedicine: findMedicine);
    result.fold((l) {
      emit(ServicesError(l));
    }, (r) {
      emit(ServicesSuccess());
    });
  }

  Future<void> sendQuestion(String userID) async {
    if (!await ConnectivityHelper.checkConnection()) {
      emit(NoInternetConnection('No internet connection'));
      return;
    }
    QuestionModel questionModel = QuestionModel(
      question: questionController.text,
      questionDetails: questionDetailsController.text,
      userId: userID,
      speciality: speciality!,
      age: int.parse(ageController.text),
      gender: gender!,
      answered: false,
    );
    emit(ServicesLoading());
    final result =
        await _servicesData.sendQuestion(questionModel: questionModel);
    result.fold((l) {
      emit(ServicesError(l));
    }, (r) {
      emit(ServicesSuccess());
    });
  }

  File? pickedImage;
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        pickedImage = File(value.path);
        emit(PickImage());
      }
    });
  }

  Future<void> uploadImage() async {
    final response = await FirebaseServices()
        .uploadImage(image: pickedImage!, filename: 'FindMedicine');
    response.fold((l) {
      emit(ServicesError(l));
    }, (r) {
      imageUrl = r;
    });
  }

  void deleteImage() {
    pickedImage = null;
    emit(PickImage());
  }
}
