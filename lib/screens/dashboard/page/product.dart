import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item.dart';
import 'package:project_admin/screens/dashboard/page/widget/profile/product_profile_item.dart';
import 'package:project_admin/theme/theme.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
              ProductItem(),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
        )
      ],
    );
  }
}
