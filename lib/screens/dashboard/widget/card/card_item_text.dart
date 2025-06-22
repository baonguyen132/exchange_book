import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class CardItemText extends StatefulWidget {
  final String text ;
  final FontWeight fontWeight ;

  const CardItemText({super.key , required this.text , required this.fontWeight});

  @override
  State<CardItemText> createState() => _CardItemTextState();
}

class _CardItemTextState extends State<CardItemText> {
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
