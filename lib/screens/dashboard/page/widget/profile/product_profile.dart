import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/profile/product_profile_item.dart';
import 'package:project_admin/theme/theme.dart';

class ProductProfile extends StatefulWidget {
  const ProductProfile({super.key});

  @override
  State<ProductProfile> createState() => _ProductProfileState();
}

class _ProductProfileState extends State<ProductProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.mainCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu bóng
            blurRadius: 10, // Độ mờ của bóng
            spreadRadius: 2, // Độ lan rộng của bóng
            offset: Offset(0, 4), // Vị trí bóng (x, y)
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Project one",
              style: TextStyle(
                  fontSize: 22, // Điều chỉnh kích thước chữ
                  color: Colors.blue, // Màu chữ
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            padding: EdgeInsets.only(right: 20 , left: 20 , bottom: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) =>  ProductProfileItem(),
            ),
          )
        ],
      ),
    );
  }
}
