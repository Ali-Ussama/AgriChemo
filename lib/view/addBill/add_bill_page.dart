import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBillPage extends StatelessWidget {
  const AddBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('add bill')
          ],
        )
      ],
    ),);
  }
}
