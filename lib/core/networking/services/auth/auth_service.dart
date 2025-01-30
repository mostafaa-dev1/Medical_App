import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserCredential>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Either<String, UserCredential>> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return Left('Google user is null');
    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return Right(await _auth.signInWithCredential(credential));
  }

  Future<Either<String, UserCredential>> signInWithFacebook() async {
    // Trigger the sign-in flow
    LoginResult? loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    if (loginResult.accessToken == null) return Left('Facebook user is null');
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return Right(await _auth.signInWithCredential(facebookAuthCredential));
  }
}
