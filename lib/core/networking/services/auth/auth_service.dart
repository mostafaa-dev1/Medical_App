import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<Either<String, User?>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}');

      if (e.code == 'email-already-in-use') {
        return Left(
          'Auth.emailUsed',
        );
      } else if (e.code == 'weak-password') {
        return Left(
          'Auth.passwordWeak',
        );
      } else if (e.code == 'network-request-failed') {
        return Left(
          'Auth.networkError',
        );
      }
      return Left(
        'Auth.unexpectedError',
      );
    }
  }

  Future<Either<String, User?>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}');
      if (e.code == 'user-not-found') {
        return Left(
          'Auth.emailNotExists',
        );
      } else if (e.code == 'wrong-password') {
        return Left(
          'Auth.worngPassword',
        );
      } else if (e.code == 'invalid-credential') {
        return Left(
          'Auth.invalidCeredentials',
        );
      } else if (e.code == 'network-request-failed') {
        return Left(
          'Auth.networkError',
        );
      }
      return Left(
        'Auth.unexpectedError',
      );
    }
  }

  Future<Either<String, UserCredential>> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return Left('Auth.unexpectedError');
    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return Right(await _auth.signInWithCredential(credential));
  }

  Future<Either<String, UserCredential>> signInWithFacebook() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final LoginResult loginResult =
        await FacebookAuth.instance.login(nonce: nonce);
    if (loginResult.status == LoginStatus.cancelled) {
      return Left('Auth.unexpectedError');
    }

    OAuthCredential facebookAuthCredential;
    if (Platform.isIOS) {
      switch (loginResult.accessToken!.type) {
        case AccessTokenType.classic:
          final token = loginResult.accessToken!.tokenString as ClassicToken;

          facebookAuthCredential =
              FacebookAuthProvider.credential(token.tokenString);
          break;
        case AccessTokenType.limited:
          final token = loginResult.accessToken!.tokenString as LimitedToken;
          facebookAuthCredential = OAuthCredential(
              providerId: 'facebook.com',
              signInMethod: 'oauth',
              idToken: token.tokenString,
              rawNonce: rawNonce);
          break;
      }
    } else {
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );
    }

    return Right(await _auth.signInWithCredential(facebookAuthCredential));
  }

  /// Generates a cryptographically secure random nonce.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Hashes the given nonce using SHA256.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Future<Either<String, UserCredential>> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   LoginResult? loginResult = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   if (loginResult.accessToken == null) return Left('Facebook user is null');
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  //   // Once signed in, return the UserCredential
  //   return Right(await _auth.signInWithCredential(facebookAuthCredential));
  // }
  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<Either<String, String>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Right('Auth.resetPasswordEmailSent');
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.resetPassword: ${e.toString()} and code is ${e.code}');
      if (e.code == 'user-not-found') {
        return Left(
          'Auth.emailNotExists',
        );
      } else if (e.code == 'network-request-failed') {
        return Left(
          'Auth.networkError',
        );
      }
      return Left(
        'Auth.unexpectedError',
      );
    }
  }
}
