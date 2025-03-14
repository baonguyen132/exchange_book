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
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.mainCard,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Màu bóng
                blurRadius: 6, // Độ mờ bóng
                spreadRadius: 2, // Độ lan của bóng
                offset: Offset(0, 4), // Dịch bóng xuống dưới
              ),
            ],
          ),
        ),
        Container(
          child: Wrap(
            alignment: MediaQuery.of(context).size.width > 500 ? WrapAlignment.spaceAround : WrapAlignment.center,
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
