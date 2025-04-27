import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/database/remote/firebase_services.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';
import 'package:medical_system/features/profile/data/profile_services/profile_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final _profileData = ProfileServices();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  String? gender;
  DateTime? selectedDate;
  final formKey = GlobalKey<FormState>();
  UserModel? user;

  void init(UserModel user) {
    firstNameController.text = user.firstName!;
    lastNameController.text = user.lastName!;
    emailController.text = user.email!;
    phoneController.text = user.phone!;
    birthdayController.text =
        DateFormat('dd-MM-yyyy').format(user.dateOfBirth!);
    gender = user.gender;
  }

  void initUser(UserModel userModel) {
    user = userModel;
  }

  void formatDate(DateTime dateTime) {
    // Format the date correctly
    birthdayController.text = DateFormat('dd-MM-yyyy').format(dateTime);

    // Parse it back using the same format instead of DateTime.parse()
    DateTime parsedDate =
        DateFormat('dd-MM-yyyy').parse(birthdayController.text);
    selectedDate = parsedDate;

    print(parsedDate); // This will now work correctly
    emit(DateSelected());
  }

  Future<void> updatePersonalInfo(UserModel user) async {
    print(user.toJson());
    emit(UpdatePersonalInfoLoading());
    if (image != null) {
      await uploadProfileImage();
    }
    log(imageUrl.toString());
    user = UserModel(
      id: user.id,
      image: imageUrl ?? user.image,
      uid: user.uid,
      addresses: user.addresses,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      dateOfBirth: selectedDate ?? user.dateOfBirth,
      gender: gender,
    );
    print(user.toJson());
    final response = await _profileData.updatePersonalInfo(
      user: user,
    );
    response.fold((l) {
      emit(UpdatePersonalInfoError(l));
    }, (r) {
      addCashedData(user);
      this.user = user;
      emit(UpdatePersonalInfoSuccess(
        user,
      ));
    });
  }

  void addCashedData(UserModel user) async {
    Storage.saveValue(key: 'id', value: user.id!);
    Storage.saveValue(key: 'uid', value: user.uid!);
    Storage.saveValue(key: 'firstName', value: user.firstName!);
    Storage.saveValue(key: 'lastName', value: user.lastName!);
    Storage.saveValue(key: 'email', value: user.email!);
    Storage.saveValue(key: 'image', value: user.image!);
    Storage.saveValue(key: 'phone', value: user.phone!);
    Storage.saveValue(key: 'dateOfBirth', value: user.dateOfBirth.toString());
    Storage.saveValue(key: 'gender', value: user.gender!);
    Storage.saveValue(key: 'address', value: user.addresses.toString());
  }

  File? image;
  String? imageUrl;

  void removeImage() {
    image = null;
    emit(ImageRemoved());
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePicked());
    }
  }

  Future<void> uploadProfileImage() async {
    final response = await FirebaseServices()
        .uploadImage(image: image!, filename: 'ProfileImages');
    response.fold((l) {
      log(l);
      emit(UpdateProfileImageError(l));
    }, (r) {
      log(r);
      imageUrl = r;
    });
  }
}
