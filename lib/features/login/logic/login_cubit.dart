import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medical_system/core/models/user.dart';
import 'package:medical_system/core/networking/services/auth/auth_service.dart';
import 'package:medical_system/core/networking/services/database/remote/supabase_services.dart';
import 'package:medical_system/core/networking/services/local_databases/secure_storage.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final auth = AuthService();
  final _subabase = SupabaseServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  void obscurePassword() {
    isPasswordObscure = !isPasswordObscure;
    emit(ObscurePassword());
  }

  User? user;
  Future<void> login() async {
    emit(LoginLoading());
    final result = await auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    result.fold((l) {
      emit(LoginError(l));
    }, (r) async {
      await getUserData(uid: r!.uid);
      emit(LoginSuccess(user!));
    });
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    final result = await auth.signInWithGoogle();
    result.fold((l) {
      emit(LoginError(l));
    }, (r) async {
      await getUserData(uid: r.user!.uid);
      emit(LoginSuccess(user!));
    });
  }

  Future<void> loginWithFacebook() async {
    emit(LoginLoading());
    final result = await auth.signInWithFacebook();
    result.fold((l) {
      emit(LoginError(l));
    }, (r) async {
      await getUserData(uid: r.user!.uid);
      emit(LoginSuccess(user!));
    });
  }

  Future<void> getUserData({required String uid}) async {
    final response = await _subabase.getDataWitheq('Users', '*', 'uid', uid);
    response.fold((l) {
      emit(LoginError(l));
    }, (r) {
      user = User.fromJson(r[0]);
      addCashedData(user!);
    });
  }

  void addCashedData(User user) async {
    Storage.saveValue(key: 'uid', value: user.uid);
    Storage.saveValue(key: 'name', value: user.name);
    Storage.saveValue(key: 'email', value: user.email);
    Storage.saveValue(key: 'image', value: user.image);
    Storage.saveValue(key: 'phone', value: user.phone);
    Storage.saveValue(key: 'dateOfBirth', value: user.dateOfBirth.toString());
    Storage.saveValue(key: 'gender', value: user.gender);
  }
}
