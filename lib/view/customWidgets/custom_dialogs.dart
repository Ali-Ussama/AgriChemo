import 'package:tarek_agro/locale/app_localization.dart';
import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,
    {@required String? message,
    String? title,
    String? positiveActionTxt,
    String? negativeActionTxt,
    bool cancelable = false,
    Function? positiveActionListener,
    Function? negativeActionListener}) {
  showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var locale = AppLocalization.of(context);
        return AlertDialog(
          title: Text(title ?? locale.translate('alert_dialog_title') ?? ""),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message ?? ""),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(positiveActionTxt ?? locale.translate('ok') ?? ""),
              onPressed: () {
                if (positiveActionListener != null) {
                  positiveActionListener.call();
                }
                Navigator.of(context).pop();
              },
            ),
            Visibility(
                visible: cancelable,
                child: TextButton(
                  child: Text(
                      negativeActionTxt ?? locale.translate('cancel') ?? ""),
                  onPressed: () {
                    if (negativeActionListener != null) {
                      negativeActionListener.call();
                    }
                    Navigator.of(context).pop();
                  },
                )),
          ],
        );
      });
}

void showLoadingDialog(var ctx) {
  showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (ctx) => SizedBox(
            width: MediaQuery.of(ctx).size.width,
            height: MediaQuery.of(ctx).size.height,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Expanded(
                    child: Center(
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ));
}
