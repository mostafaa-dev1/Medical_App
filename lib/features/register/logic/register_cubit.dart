import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/auth/auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;

  User? user;
  void obscurePassword() {
    isPasswordObscure = !isPasswordObscure;
    emit(ObscurePassword());
  }

  Future<void> register() async {
    emit(RegisterLoading());
    final result = await auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    result.fold((l) {
      emit(RegisterError(l));
    }, (response) {
      user = User(
        uid: response!.uid,
        name: response.displayName ?? "",
        gender: "",
        dateOfBirth: DateTime.now(),
        email: response.email!,
        image: response.photoURL ?? "",
        phone: response.phoneNumber ?? "",
      );
      log(user!.toJson().toString());
      emit(RegisterSuccess());
    });
  }

  Future<void> signUpWithGoogle() async {
    final result = await auth.signInWithGoogle();
    result.fold((l) {
      emit(RegisterError(l));
    }, (response) {
      user = User(
        uid: response.user!.uid,
        name: response.user!.displayName ?? "",
        gender: "",
        dateOfBirth: DateTime.now(),
        email: response.user!.email!,
        image: response.user!.photoURL ?? "",
        phone: response.user!.phoneNumber ?? "",
      );
      log(user!.toJson().toString());

      emit(RegisterSuccess());
    });
  }

  Future<void> signUpWithFacebook() async {
    final result = await auth.signInWithFacebook();
    result.fold((l) {
      emit(RegisterError(l));
    }, (r) {
      user = User(
        uid: r.user!.uid,
        name: r.user!.displayName ?? "",
        gender: "",
        dateOfBirth: DateTime.now(),
        email: r.user!.email!,
        image: r.user!.photoURL ?? "",
        phone: r.user!.phoneNumber ?? "",
      );
      log(
        user!.toJson().toString(),
      );
      emit(RegisterSuccess());
    });
  }
}
