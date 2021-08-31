

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _auth= FirebaseAuth.instance;

  static User get currentUser => getCurrentUser()!;


  Future<UserCredential?> loginUser(String email,
      String password,) async{
    try{
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    }catch(e){
      // print(e);
      return null;
    }
  }

  Future<UserCredential?> createNewUser(String email, String password) async{
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser;
    }catch(e){
      print(e);
      return null;
    }
  }

  void resetPassword({required String email}){
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyPhone() async{
    await _auth.verifyPhoneNumber(
      phoneNumber: '+1 216 304 8714',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static String? getCurrentUserUid(){
    if (_auth.currentUser == null) {
      return null;
    }

    return _auth.currentUser!.uid;

  }

  static User? getCurrentUser(){
    if (_auth.currentUser == null) {
      return null;
    }

    return _auth.currentUser!;

  }

  static logoutUser() => _auth.signOut();

}