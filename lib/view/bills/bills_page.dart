import 'package:flutter/material.dart';

class BillsPage extends StatelessWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('bills')],
          )
        ],
      ),
    );
  }
}
