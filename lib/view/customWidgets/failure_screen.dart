import 'dart:developer';

import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/utils/enums.dart';
import 'package:tarek_agro/utils/token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

showFailureScreen(
    {String? actionText,
    int? errorCode,
    String? message,
    String? details,
    required BuildContext mContext,
    bool? isDismissible,
    Function? retryAction,
    Function? closeAction}) {
  showModalBottomSheet(
      context: mContext,
      builder: (context) {
        var local = AppLocalization.of(context);

        return SafeArea(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 56.0, right: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 32.0,
                      onPressed: () {
                        if (closeAction != null) closeAction.call();
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/yelo_logo_svg.svg',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                )),
            Container(
              margin: const EdgeInsets.all(32.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Center(
                            child: Text(
                      message ?? "",
                      style: const TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )))
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      child: Center(
                    child: Text(
                      details ?? "",
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ))
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 48.0, top: 24.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 6.0,
                        padding: const EdgeInsets.all(16.0),
                        primary: ColorsUtils.secondary,
                        onPrimary: ColorsUtils.primary,
                      ),
                      child: Text(
                        actionText ??
                            ((errorCode != null &&
                                    errorCode ==
                                        NetworkStatusCodes
                                            .unAuthorizedUser.value)
                                ? local.translate('login') ??
                                    local.translate('retry') ??
                                    ""
                                : ""),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        log("error code: $errorCode");
                        if (errorCode != null &&
                            errorCode ==
                                NetworkStatusCodes.unAuthorizedUser.value) {
                          TokenUtil.clearToken();
                          Navigator.pop(context);
                          //TODO UnAuthorized Error navigate to login page
                          // Navigator.pushReplacement(
                          //     mContext,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoginScreen()));
                        } else if (retryAction != null) {
                          retryAction.call();
                          log("onPressed");
                          Navigator.pop(context);
                        }
                      }),
                ))
              ],
            )
          ],
        ));
      },
      isScrollControlled: true,
      enableDrag: isDismissible ?? false);
}
