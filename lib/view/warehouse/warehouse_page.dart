
import 'package:flutter/material.dart';

class WareHousePage extends StatelessWidget {
  const WareHousePage({Key? key}) : super(key: key);

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
            Text('warehouse')
          ],
        )
      ],
    ),);
  }
}