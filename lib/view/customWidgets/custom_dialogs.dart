import 'package:tarek_agro/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/utils/colors_utils.dart';

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

Future<dynamic> showAddEditUnit(var context, {String? unitName}) {
  return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        var locale = AppLocalization.of(context);
        var unitNameController = TextEditingController(text: unitName ?? "");
        return StatefulBuilder(builder: (context, refresh) {
          return AlertDialog(
              // insetPadding: const EdgeInsets.all(24),
              clipBehavior: Clip.hardEdge,
              contentPadding: const EdgeInsets.all(16.0),
              scrollable: true,
              title: Text(
                locale.translate('add_new_unit') ?? "Add New Unit",
              ),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
              content: Container(
                margin: const EdgeInsets.only(top:8.0,bottom: 16.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 24.0, left: 8.0, right: 8.0, bottom: 24.0),
                      child: TextFormField(
                        controller: unitNameController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        validator: (String? value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:
                              locale.translate("unit_name") ?? "Unit name",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(locale.translate('cancel') ?? ''),
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                      color: ColorsUtils.secondary)),
                            )
                          ],
                      ),),
                      Expanded(child: Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context,[unitNameController.text]);
                          },
                          child: Text(unitName == null ? locale.translate('add') ?? '' : locale.translate('update') ?? ''),
                          style: ElevatedButton.styleFrom(primary: ColorsUtils.secondary,padding: const EdgeInsets.all(8.0)),
                        ),))
                    ],)
                  ],
                ),
              ));
        });
      });
}
