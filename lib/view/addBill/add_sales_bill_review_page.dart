import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/add_bill/add_bill_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';

class AddSalesBillReviewPage extends StatelessWidget {
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
          margin: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductDetailsHeader(),
                      ProductsListDetails(),
                      BillingTotalInfo(),
                      const ActualPaidAmount(),
                      Attachments()
                    ],
                  ),
                ),
              ),
              const BottomShadow(),
              const NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class Attachments extends StatelessWidget {
  const Attachments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )),
              ),
              Text(locale.translate('add_attachment') ?? '')
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: addBillProvider.attachments.length,
                    itemBuilder: (context, index) {
                      var url = addBillProvider.attachments[index];
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        margin:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Image.network(url),
                        ),
                      );
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProductsListDetails extends StatelessWidget {
  const ProductsListDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: ListView.builder(
          itemCount: addBillProvider.addedProducts.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Product product = addBillProvider.addedProducts[index];
            return ProductDetailsRowItem(
                name: product.name,
                amount: "${product.quantity ?? 1}",
                price: product.price.toString(),
                unitName: product.unit?.name,
                total: "${product.price! * (product.quantity ?? 1)}");
          }),
    );
  }
}

class ProductDetailsRowItem extends StatelessWidget {
  String? name, amount, price, unitName, total;

  ProductDetailsRowItem(
      {Key? key, this.name, this.amount, this.price, this.unitName, this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                name ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    amount ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  const Text(
                    " X ",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  Text(
                    price ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                unitName ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Text(
                total ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(top: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.grey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  locale.translate('name') ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "( ${locale.translate('quantity') ?? ''} x ${locale.translate('price') ?? ''} )",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  locale.translate('unit') ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                locale.translate('total') ?? '',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillingTotalInfo extends StatelessWidget {
  const BillingTotalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    var locale = AppLocalization.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: ColorsUtils.petroleumBlue)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(child: Text(locale.translate('total_bill') ?? '')),
                Text(
                  "${addBillProvider.getTotalBillPrice()} ${locale.translate('egp')}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
            color: ColorsUtils.petroleumBlue,
            height: 1.0,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child:
                        Text(locale.translate('previous_inDebt_amount') ?? '')),
                Text(
                  "${addBillProvider.getInDebtAmount()} ${locale.translate('egp')}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
            height: 1.0,
            color: ColorsUtils.petroleumBlue,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(child: Text(locale.translate('total') ?? '')),
                Text(
                  "${addBillProvider.getTotalBillPrice() + addBillProvider.getInDebtAmount()} ${locale.translate('egp')}",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ActualPaidAmount extends StatelessWidget {
  const ActualPaidAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    var locale = AppLocalization.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      color: Colors.white,
      child: Form(
        key: addBillProvider.reviewFormKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: addBillProvider.paidAmountController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                    labelText: locale.translate("enter_paid_amount") ??
                        "Enter Paid Amount",
                    labelStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid))),
                onChanged: (String? newQuantity) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return locale.translate('please_enter_paid_amount') ?? '';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomShadow extends StatelessWidget {
  const BottomShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade300, Colors.grey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);

    return Container(
      margin: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              if (addBillProvider.isReviewPageAllValid()) {
                navigateToHome(context);
              }
            },
            child: Text(locale.translate('save') ?? ''),
            style: ElevatedButton.styleFrom(
                primary: ColorsUtils.secondary, onPrimary: Colors.white),
          ))
        ],
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
