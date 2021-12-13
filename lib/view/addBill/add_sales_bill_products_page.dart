import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/add_bill/add_bill_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/addBill/add_sales_bill_review_page.dart';
import 'package:tarek_agro/view/customWidgets/custom_dialogs.dart';

class AddSalesBillProductsPage extends StatefulWidget {
  AddSalesBillProductsPage({Key? key}) : super(key: key);

  @override
  State<AddSalesBillProductsPage> createState() =>
      _AddSalesBillProductsPageState();
}

class _AddSalesBillProductsPageState extends State<AddSalesBillProductsPage> {
  @override
  void initState() {
    var addBillProvider =
        Provider.of<AddSalesBillProvider>(context, listen: false);
    addBillProvider.getProducts();
    addBillProvider.getUnits();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return WillPopScope(
      onWillPop: () {
        addBillProvider.destroyAddProducts();
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
              addBillProvider.destroyAddProducts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              const SearchProductWidget(),
              ProductsList(),
              Container(
                height: 12,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.grey.shade300,
                  Colors.grey
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              const Total(),
              const NextButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Autocomplete<Product>(
        displayStringForOption: _displayStringForProduct,
        fieldViewBuilder: _fieldViewBuilder,
        optionsViewBuilder: _optionViewBuild,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<Product>.empty();
          }
          return addBillProvider.allProducts.where((Product option) {
            return option.name!.contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (Product selection) {
          if (!addBillProvider.isListContainsThisProduct(selection)) {
            addBillProvider.addProductToList(selection);
          } else {
            showAlertDialog(context,
                message: locale.translate('product_already_exists'));
          }
        },
      ),
    );
  }

  static String _displayStringForProduct(Product? option) => option?.name ?? '';

  Widget _fieldViewBuilder(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    var locale = AppLocalization.of(context);
    return TextField(
      focusNode: focusNode,
      controller: textEditingController,
      decoration: InputDecoration(
          labelText: locale.translate('search_item'),
          prefixIcon: SizedBox(
            width: 16.0,
            height: 16.0,
            child: SvgPicture.asset(
              'images/ic_product.svg',
              width: 16.0,
              height: 16.0,
              fit: BoxFit.scaleDown,
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey))),
      onSubmitted: (String? value) {
        textEditingController.text = '';
        onFieldSubmitted.call();
      },
    );
  }

  Widget _optionViewBuild(
      BuildContext context,
      AutocompleteOnSelected<Product>? onSelected,
      Iterable<Product?>? options) {
    return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .85,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 0),
              shrinkWrap: true,
              itemCount: options?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final Product? option = options?.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    if (option != null) {
                      onSelected?.call(option);
                    }
                  },
                  child: Builder(builder: (BuildContext context) {
                    final bool highlight =
                        AutocompleteHighlightedOption.of(context) == index;
                    if (highlight) {
                      SchedulerBinding.instance!
                          .addPostFrameCallback((Duration timeStamp) {
                        Scrollable.ensureVisible(context, alignment: 0.5);
                      });
                    }
                    return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _displayStringForProduct(option),
                        textDirection: TextDirection.ltr,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ));
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Expanded(
      child: Form(
        key: addBillProvider.productsFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
          child: ListView.builder(
              itemCount: addBillProvider.addedProducts.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var product = addBillProvider.addedProducts[index];
                addBillProvider.initializeNewAddProductControllers(
                    product, index);

                return Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: ColorsUtils.secondary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: SvgPicture.asset(
                              'images/ic_product.svg',
                              width: 24,
                              height: 24,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(
                                top: 16.0, left: 16.0, right: 16.0),
                            child: Text(
                              product.name ?? '',
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w300),
                            ),
                          )),
                          IconButton(
                              onPressed: () {
                                showAlertDialog(context,
                                    title: locale.translate('warning'),
                                    message:
                                        "${locale.translate('are_you_sure_to_delete')} ${product.name} ؟",
                                    cancelable: true,
                                    positiveActionListener: () {
                                  addBillProvider.deleteAddedProduct(
                                      product, index);
                                });
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 16,
                                    right: 16,
                                    bottom: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: addBillProvider
                                            .amountControllers[index],
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                            labelText:
                                                locale.translate("quantity") ??
                                                    "Quantity",
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                    style: BorderStyle.solid))),
                                        onChanged: (String? newQuantity) {
                                          if (newQuantity != null &&
                                              newQuantity.isNotEmpty) {
                                            if (addBillProvider.isValidQuantity(
                                                product.id!, newQuantity)) {
                                              addBillProvider
                                                  .setProductQuantity(
                                                      product, newQuantity);
                                            } else {
                                              showAlertDialog(context,
                                                  title: locale
                                                      .translate('warning'),
                                                  message:
                                                      "${locale.translate('you_cannot_sell_more_than_store_quantity')}");
                                            }
                                          } else {
                                            addBillProvider.setProductQuantity(
                                                product, "0");
                                          }
                                        },
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return locale.translate(
                                                    'quantity_is_required') ??
                                                '';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 16,
                                    right: 16,
                                    bottom: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: addBillProvider
                                            .priceControllers[index],
                                        textAlign: TextAlign.start,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        textInputAction: TextInputAction.done,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                            labelText:
                                                locale.translate("price") ??
                                                    "Price",
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                    style: BorderStyle.solid))),
                                        onChanged: (String? newPrice) {
                                          if (newPrice != null &&
                                              newPrice.isNotEmpty) {
                                            addBillProvider.setProductPrice(
                                                product, newPrice);
                                          } else {
                                            addBillProvider.setProductPrice(
                                                product, "0.0");
                                          }
                                        },
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return locale.translate(
                                                    'price_is_required') ??
                                                '';
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      addBillProvider.allUnits.isNotEmpty
                          ? ChooseUnit(product: product)
                          : Container(),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class ChooseUnit extends StatefulWidget {
  Product? product;

  ChooseUnit({Key? key, this.product}) : super(key: key);

  @override
  State<ChooseUnit> createState() => _ChooseUnitState();
}

class _ChooseUnitState extends State<ChooseUnit> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      locale.translate('main_unit') ?? '',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: addBillProvider.allUnits.map((Unit unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (Unit? newUnit) {
                          if (newUnit != null) {
                            addBillProvider.setSelectedProductUnit(
                                widget.product, newUnit);
                          }
                        },
                        value: widget.product?.unit != null
                            ? addBillProvider.getUnitById(widget.product?.unit)
                            : null,
                        isExpanded: true,
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Total extends StatelessWidget {
  const Total({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var addBillProvider = Provider.of<AddSalesBillProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              locale.translate('total') ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: ColorsUtils.petroleumBlue),
            ),
          ),
          Text(
            "${addBillProvider.getTotalBillPrice()} ${locale.translate('egp') ?? ''}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: ColorsUtils.petroleumBlue),
          )
        ],
      ),
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
              if (addBillProvider.isAllValid()) {
                navigateToSalesBillReviewPage(context);
              }
            },
            child: Text(locale.translate('next') ?? ''),
            style: ElevatedButton.styleFrom(
                primary: ColorsUtils.secondary, onPrimary: Colors.white),
          ))
        ],
      ),
    );
  }

  void navigateToSalesBillReviewPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddSalesBillReviewPage()));
  }
}
