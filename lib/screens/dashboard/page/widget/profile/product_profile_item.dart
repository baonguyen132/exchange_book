import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

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
      width: 300,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: Colors.blue,
              width: 3
          )
      ),
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-hhlczgZCexRKviMmym1IW_Xngpb6ec3BWQ&s"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.all(16), // Thêm padding cho nội dung
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
                      children: [
                        Text(
                          "📖 Sách: Tiếng Việt 1", // Thêm emoji tạo điểm nhấn
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal, // Chữ đậm hơn
                              color: Theme.of(context).colorScheme.maintext, decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "💰 Giá: 10.000 VND",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.maintext,
                              decoration: TextDecoration.none
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8) ,
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
