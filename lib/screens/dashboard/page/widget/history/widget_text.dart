import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

class WidgetText extends StatefulWidget {

  IconData icon ;
  String tilte , content ;

  WidgetText({super.key , required this.icon , required this.tilte , required this.content});

  @override
  State<WidgetText> createState() => _WidgetTextState();
}

class _WidgetTextState extends State<WidgetText> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          size: 20,
          widget.icon,
        ) ,
        SizedBox(width: 15,),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${widget.tilte}: ${widget.content}", // Phần có màu mặc định
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
    );
  }
}
