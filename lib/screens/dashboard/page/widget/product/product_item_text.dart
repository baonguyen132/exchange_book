import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

class ProductItemText extends StatefulWidget {
  String text ;
  FontWeight fontWeight ;

  ProductItemText({super.key , required this.text , required this.fontWeight});

  @override
  State<ProductItemText> createState() => _ProductItemTextState();
}

class _ProductItemTextState extends State<ProductItemText> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.text, // Phần có màu mặc định
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: widget.fontWeight,
                  color: Theme.of(context).colorScheme.maintext, // Đổi màu tùy theo theme nếu cần
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
