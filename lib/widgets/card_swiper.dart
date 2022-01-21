import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight)) /
          2,
      color: Colors.red,
    );
  }
}
