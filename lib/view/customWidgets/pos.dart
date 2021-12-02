import 'dart:developer';

import 'package:tarek_agro/utils/Constants.dart';
import 'package:tarek_agro/utils/preference_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class POS {
  static String? _terminalId = '';

  static Future<void> loadTerminalIDToMemory() async {
    _terminalId =
        await PreferenceManager.getInstance()?.getString(Constants.TERMINAL_ID);
  }

  static String getTerminalFromMemory() {
    return _terminalId ?? "";
  }

  static void saveTerminalId(String terminalId) {
    PreferenceManager.getInstance()?.saveString(Constants.TERMINAL_ID, terminalId);
    loadTerminalIDToMemory();
  }

  static void clearTerminalId() {
    PreferenceManager.getInstance()?.remove(Constants.TERMINAL_ID);
    _terminalId = '';
  }

  static Future<dynamic> openPosForTransaction(double amountToPay) async {
    try {
      Fluttertoast.showToast(
          msg: "Open POS For Purchase",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          timeInSecForIosWeb: 1);

      const methodChannel = MethodChannel('ejar.pos/purchase');
      String resultPOSJson = '';
      var result = await methodChannel.invokeMethod(
          Constants.POS_METHOD_PURCHASE, {
        Constants.AMOUNT: amountToPay,
        Constants.PURCHASE_ORDER_ID: 123456987,
        Constants.TERMINAL_ID: getTerminalFromMemory()
        // Constants.TERMINAL_ID: "63237447"
      });
      if (result != null) {
        resultPOSJson = result.toString();
        log("POS RESULT: $resultPOSJson");
      }
      return result;
    } on PlatformException catch (e) {
      log(e.message ?? "");
    }
    return null;
  }


  static Future<dynamic> openPosForRegistration() async {
    try {
      String resultPOSJson = '';
      const methodChannel = MethodChannel('ejar.pos/purchase');
      var result = await methodChannel.invokeMethod(
          Constants.POS_METHOD_REGISTER, {
        Constants.TERMINAL_ID: getTerminalFromMemory()
      });
      if (result != null) {
        resultPOSJson = result.toString();
        log("POS RESULT: $resultPOSJson");
      }
      return result;
    } on PlatformException catch (e) {
      log(e.message ?? "");
    }
    return null;
  }


  static Future<dynamic> openPosForReconciliation() async {
    try {
      const methodChannel = MethodChannel('ejar.pos/purchase');
      String resultPOSJson = '';
      var result = await methodChannel.invokeMethod(
          Constants.POS_METHOD_RECONCILIATION, {
        Constants.TERMINAL_ID: getTerminalFromMemory()
      },);
      if (result != null) {
        resultPOSJson = result.toString();
        log("POS RESULT: $resultPOSJson");
      }
      return result;
    } on PlatformException catch (e) {
      log(e.message ?? "");
    }
    return null;
  }
}
