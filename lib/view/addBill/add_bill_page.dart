import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/addBill/add_sales_bill_select_client_page.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({Key? key}) : super(key: key);

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  bool isClientSelected = true;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if(!isClientSelected) {
                              isClientSelected = !isClientSelected;
                            }
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color:
                          isClientSelected ? ColorsUtils.secondary : Colors.white,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(locale.translate('clients') ?? '',
                                    style: TextStyle(
                                        color: isClientSelected
                                            ? Colors.white
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              if(isClientSelected) {
                                isClientSelected = !isClientSelected;
                              }                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: !isClientSelected
                                ? ColorsUtils.secondary
                                : Colors.white,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(locale.translate('suppliers') ?? '',
                                      style: TextStyle(
                                          color: !isClientSelected
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Visibility(
              visible: isClientSelected,
              child: Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: const AddSalesBillSelectClientPage(),
                ),
              ),
            ),
            Visibility(
              visible: !isClientSelected,
              child: Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
