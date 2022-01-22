import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/add_bill/add_bill_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/addBill/add_sales_bill_products_page.dart';
import 'package:tarek_agro/view/customWidgets/custom_dialogs.dart';

class AddSalesBillActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);

    return WillPopScope(
        onWillPop: () {
          addBillProvider.destroyClient();
          return Future.value(true);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(locale.translate('create_sales_bill') ?? ''),
              titleTextStyle:
                  const TextStyle(fontSize: 20.0, color: Colors.black),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black54,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  addBillProvider.destroyClient();
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8, bottom: 8),
                      color: ColorsUtils.alphaBlue,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 16.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset('images/ic_person.svg'),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 24.0, right: 24.0),
                                      child: Text(
                                        addBillProvider.client?.name ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 16.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.phone_outlined,
                                      color: Colors.black),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Text(
                                      addBillProvider.client?.phone ?? '',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 16.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      color: Colors.black),
                                  Expanded(
                                      child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: Text(
                                      addBillProvider.client?.address ?? '',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          'images/ic_paid_dollar.svg'),
                                      Text(
                                        addBillProvider.client?.paid
                                                ?.toString() ??
                                            '',
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                      Text(locale.translate('paid') ?? '')
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      SvgPicture.asset('images/ic_dollar.svg'),
                                      Text(
                                        addBillProvider.client?.remaining
                                                ?.toString() ??
                                            '',
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(locale.translate('remaining') ?? '')
                                    ],
                                  )),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      SvgPicture.asset('images/ic_dollar.svg'),
                                      Text(addBillProvider.client?.inDebt
                                              ?.toString() ??
                                          ''),
                                      Text(locale.translate('in_debt') ?? '')
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Visibility(
                      visible: !addBillProvider.isCollectingMoneyVisible,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            navigateToCreateSalesBillItems(context);
                          },
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8, bottom: 8),
                            color: Colors.white,
                            child: Container(
                                margin: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.add_circle_outline,
                                        color: Colors.black),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Expanded(
                                          child: Text(
                                              locale.translate("create_bill") ??
                                                  '')),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      )),
                  Visibility(
                      visible: !addBillProvider.isCollectingMoneyVisible,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            displayHideCollectingMoneyViews(
                                context, addBillProvider);
                          },
                          child: Card(
                            margin: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8, bottom: 8),
                            color: Colors.white,
                            child: Container(
                                margin: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'images/ic_collect_money.svg',
                                      matchTextDirection: true,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Expanded(
                                          child: Text(
                                              locale.translate("collecting") ??
                                                  '')),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      )),
                  Visibility(
                      visible: addBillProvider.isCollectingMoneyVisible,
                      child: CollectMoneyPage())
                ],
              ),
            )));
  }

  void navigateToCreateSalesBillItems(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddSalesBillProductsPage()));
  }

  void displayHideCollectingMoneyViews(
      BuildContext context, AddSalesBillProvider addBillProvider) {
    addBillProvider.setCollectingMoneyVisibility();
  }
}

class CollectMoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);

    return Form(
      key: addBillProvider.collectMoneyFormKey,
      child: Expanded(
        child: Column(
          children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(
                  top: 16.0, left: 16, right: 16, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: addBillProvider.amountController,
                      textAlign: TextAlign.start,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return locale.translate('please_enter_paid_amount') ??
                              '';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: locale.translate("enter_paid_amount") ??
                              "Enter Paid Amount",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                  style: BorderStyle.solid))),
                    ),
                  )
                ],
              ),
            )),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 24.0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: TextButton(
                              onPressed: () {
                                displayHideCollectingMoneyViews(
                                    context, addBillProvider);
                              },
                              child: Text(
                                locale.translate('cancel') ?? '',
                                style: const TextStyle(
                                    color: ColorsUtils.secondary,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: TextButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1)),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (addBillProvider.isCollectMoneyInputsValid()) {
                              showAlertDialog(context,
                                  message:
                                      "${locale.translate('are_you_sure_to_collect_money') ?? ''} ${addBillProvider.amountController.text} ${locale.translate('egp')} ؟",
                                  negativeActionTxt: locale.translate('cancel'),
                                  cancelable: true, positiveActionListener: () {
                                addBillProvider.saveCollectingMoney();
                                displayHideCollectingMoneyViews(
                                    context, addBillProvider);
                              });
                            }
                          },
                          child: Text(locale.translate('save') ?? ''),
                          style: ElevatedButton.styleFrom(
                              primary: ColorsUtils.secondary,
                              padding: const EdgeInsets.all(8.0)),
                        ),
                      ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void displayHideCollectingMoneyViews(
      BuildContext context, AddSalesBillProvider addBillProvider) {
    addBillProvider.setCollectingMoneyVisibility();
  }
}
