import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());

  final _supabase = SupabaseServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String gender = 'Male';
  int gernderIndex = 0;
  void changeGenderIndex(int index) {
    gernderIndex = index;
    setGender(index == 0 ? 'Male' : 'Female');
    emit(GenderIndexChanged());
  }

  void setGender(String value) {
    gender = value;
    emit(GenderSelected());
  }

  File? profileImage;
  void pickImage() {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        profileImage = File(value.path);
      }
    });
  }

  Future<void> uploadImage() async {
    if (profileImage != null) {
      emit(UploadImageLoading());
      final response = await _supabase.uploadImage(file: profileImage!);
      response.fold((error) {
        emit(UploadImageError(error));
      }, (fileName) async {
        await getImageUrl(fileName);
        emit(UploadImageSuccess());
      });
    }
  }

  String imageUrl = '';
  Future<void> getImageUrl(String fileName) async {
    emit(GetImageUrlLoading());
    final response = await _supabase.getPublicUrl(fileName: fileName);
    response.fold((l) {
      emit(UploadingImageError(l));
    }, (r) {
      imageUrl = r;
      emit(UploadingImageSuccess());
    });
  }

  void formatDate(DateTime dateTime) {
    dateController.text = DateFormat('dd/MM/yyyy').format(dateTime);
    emit(DateSelected());
  }

  Future<void> uploadPersonalInfo(User user) async {
    emit(UploadPersonalInfoLoading());
    user.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      dateOfBirth: DateTime.parse(dateController.text),
      gender: gender,
      image: imageUrl,
    );
    final response = await _supabase.setData('Users', user.toJson());
    response.fold((error) {
      emit(UploadPersonalInfoError(error));
    }, (response) {
      emit(UploadPersonalInfoSuccess());
    });
  }

  Future<void> managePersonalInfo(User user) async {
    await uploadImage();
    await uploadPersonalInfo(user);
  }
}
