import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/theme/theme.dart';

class ProductItemInfor extends StatefulWidget {
  const ProductItemInfor({super.key});

  @override
  State<ProductItemInfor> createState() => _ProductItemInforState();
}

class _ProductItemInforState extends State<ProductItemInfor> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,

        padding: EdgeInsets.all(16), // Thêm padding cho nội dung
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
          children: [
            Expanded(
              child: ListView(
                children: [
                  Wrap(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "📖 Sách: ", // Phần có màu xanh
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                              text: "Tiếng Việt tập 1", // Phần có màu mặc định
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.maintext, // Đổi màu tùy theo theme nếu cần
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Wrap(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "💰 Giá: ", // Phần có màu xanh
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                              text: "10.000 VND", // Phần có màu mặc định
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.maintext, // Đổi màu tùy theo theme nếu cần
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) ,
                ],
              ),
            ),
            SizedBox(height: 8) ,
            Container(
              child: ProductItemButton(
                color: Colors.blue,
                text: "Mua", hanlde: () {

                },),
            )
          ],
        ),
      ),
    );
  }
}
