import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/addBill/add_bill_page.dart';
import 'package:tarek_agro/view/bills/bills_page.dart';
import 'package:tarek_agro/view/clientsAndSuppliers/clients_and_suppliers_page.dart';
import 'package:tarek_agro/view/more/more_page.dart';
import 'package:tarek_agro/view/warehouse/warehouse_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedMenuItemIndex = 2;
  var bottomNavigationItems = [
    const WareHousePage(),
    const ClientsAndSuppliersPage(),
    const AddBillPage(),
    const BillsPage(),
    const MorePage()
  ];

  @override
  Widget build(BuildContext context) {
    AppLocalization locale = AppLocalization.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                child: const Icon(Icons.house, color: Colors.grey),
                padding: const EdgeInsets.all(8.0),
              ),
              label: locale.translate('warehouse'),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: const Icon(Icons.people, color: Colors.grey),
                padding: const EdgeInsets.all(8.0),
              ),
              label: locale.translate('clients'),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset("images/ic_add_bill.svg"),
                padding: const EdgeInsets.all(8.0),
              ),
              label: locale.translate('add_bill'),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset("images/bills.svg"),
                padding: const EdgeInsets.all(8.0),
              ),
              label: locale.translate('bills'),
            ),
            BottomNavigationBarItem(
              icon: Container(
                child: SvgPicture.asset(
                  "images/ic_horizontal_dots.svg",
                ),
                padding: const EdgeInsets.all(8.0),
              ),
              label: locale.translate('more'),
            ),
          ],
          currentIndex: _selectedMenuItemIndex,
          selectedItemColor: ColorsUtils.secondary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          elevation: 8.0,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
        body: bottomNavigationItems[_selectedMenuItemIndex],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedMenuItemIndex = index;
    });
  }
}
