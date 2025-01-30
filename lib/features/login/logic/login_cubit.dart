import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/networking/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final auth = AuthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  void obscurePassword() {
    isPasswordObscure = !isPasswordObscure;
    emit(ObscurePassword());
  }

  Future<void> login() async {
    emit(LoginLoading());
    final result = await auth.signInWithEmailAndPassword(
        emailController.text, passwordController.text);
    result.fold((l) {
      emit(LoginError(l));
    }, (r) {
      emit(LoginSuccess());
    });
  }

  Future<void> loginWithGoogle() async {
    final result = await auth.signInWithGoogle();
    result.fold((l) {
      emit(LoginError(l));
    }, (r) {
      emit(LoginSuccess());
    });
  }

  Future<void> loginWithFacebook() async {
    final result = await auth.signInWithFacebook();
    result.fold((l) {
      emit(LoginError(l));
    }, (r) {
      emit(LoginSuccess());
    });
  }
}
