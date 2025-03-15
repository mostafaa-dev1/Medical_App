import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/database/remote/firebase_services.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitial());

  final _supabase = SupabaseServices();
  final _firebase = FirebaseServices();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
        emit(PickImage());
      }
    });
  }

  String imageUrl = '';
  Future<void> uploadImage() async {
    if (profileImage != null) {
      emit(UploadImageLoading());
      final response = await _firebase.uploadImage(image: profileImage!);
      response.fold((error) {
        print(error);
        emit(UploadImageError(error));
      }, (url) async {
        imageUrl = url;
        emit(UploadImageSuccess());
      });
    }
  }

  Future<void> getImageUrl(String fileName) async {
    emit(GetImageUrlLoading());
    final response = await _supabase.getPublicUrl(fileName: fileName);
    response.fold((l) {
      emit(UploadingImageError(l));
    }, (r) {
      print(r);
      imageUrl = r;
      emit(UploadingImageSuccess());
    });
  }

  DateTime? selectedDate;
  void formatDate(DateTime dateTime) {
    // Format the date correctly
    dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);

    // Parse it back using the same format instead of DateTime.parse()
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(dateController.text);
    selectedDate = parsedDate;

    print(parsedDate); // This will now work correctly
    emit(DateSelected());
  }

  Future<void> uploadPersonalInfo(User user) async {
    emit(UploadPersonalInfoLoading());
    user.id = generateCustomId();
    user.firstName = firstNameController.text;
    user.lastName = lastNameController.text;
    user.phone = phoneController.text;
    user.dateOfBirth = selectedDate!;
    user.gender = gender;
    user.image = imageUrl;
    final response = await _supabase.setData('Users', user.toJson());
    response.fold((error) {
      print(user.toJson());
      print(error);
      emit(UploadPersonalInfoError(error));
    }, (response) {
      addCashedData(user);
      emit(UploadPersonalInfoSuccess());
    });
  }

  Future<void> managePersonalInfo(User user) async {
    await uploadImage();
    await uploadPersonalInfo(user);
  }

  void addCashedData(User user) async {
    Storage.saveValue(key: 'id', value: user.id);
    Storage.saveValue(key: 'uid', value: user.uid);
    Storage.saveValue(key: 'firstName', value: user.firstName);
    Storage.saveValue(key: 'lastName', value: user.lastName);
    Storage.saveValue(key: 'email', value: user.email);
    Storage.saveValue(key: 'image', value: user.image);
    Storage.saveValue(key: 'phone', value: user.phone);
    Storage.saveValue(key: 'dateOfBirth', value: user.dateOfBirth.toString());
    Storage.saveValue(key: 'gender', value: user.gender);
    Storage.saveValue(key: 'address', value: user.adresses.toString());
  }

  String generateCustomId() {
    String prefix = "PAT-";

    DateTime now = DateTime.now();
    String datePart = "${now.year % 100}${now.month}${now.day}";

    String randomPart = Random().nextInt(9000).toString().padLeft(4, '0');

    return "$prefix$datePart$randomPart";
  }
}
