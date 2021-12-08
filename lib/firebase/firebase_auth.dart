import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticate {

  FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential?>? authenticate(String username, String password) async{
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
    return null;
  }

  static void logout(){
    FirebaseAuth.instance.signOut();
  }
}
