
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/add_bill/add_bill_provider.dart';

class AddSalesBillReviewPage extends StatelessWidget{
  const AddSalesBillReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return WillPopScope(
      onWillPop: () {
        addBillProvider.destroyReviewPageData();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.translate('create_sales_bill') ?? ''),
          titleTextStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              addBillProvider.destroyReviewPageData();
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }

}