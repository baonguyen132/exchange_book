import 'package:flutter/material.dart';

class ProductProfileItem extends StatefulWidget {
  const ProductProfileItem({super.key});

  @override
  State<ProductProfileItem> createState() => _ProductProfileItemState();
}

class _ProductProfileItemState extends State<ProductProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 250,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: Colors.blue,
              width: 3
          )
      ),
    );
  }
}
