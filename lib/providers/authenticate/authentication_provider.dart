import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/firebase/firebase_auth.dart';

class AuthenticationProvider extends ChangeNotifier {

  String? username;
  String? password;
  bool isPasswordHidden = false;

  bool isValidInputs() {
    var isAllValid = true;
    if (!isValidUsername()) isAllValid = false;
    if (!isValidPassword()) isAllValid = false;
    return isAllValid;
  }

  bool isValidUsername() => username != null && username!.isNotEmpty;

  bool isValidPassword() => password != null && password!.isNotEmpty;

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  bool isUserLoggedInBefore() => FirebaseAuth.instance.currentUser?.uid != null;

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  Future<UserCredential?>? login() async {
    return FirebaseAuthenticate.authenticate(username!, password!);
  }
}