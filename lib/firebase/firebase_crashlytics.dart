
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class FirebaseCrashes {

   static initialize() async{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  }

  static setUserInfo(String username,branchId)async{
     await FirebaseCrashlytics.instance.setUserIdentifier("User: $username - Branch: $branchId");
  }
}