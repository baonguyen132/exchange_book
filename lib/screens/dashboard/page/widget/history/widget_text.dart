import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

class WidgetText extends StatefulWidget {

  IconData icon ;
  String title , content ;

  WidgetText({super.key , required this.icon , required this.title , required this.content});

  @override
  State<WidgetText> createState() => _WidgetTextState();
}

class _WidgetTextState extends State<WidgetText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          widget.icon,
          size: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: "${widget.title}: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.maintext,
                decoration: TextDecoration.none,
              ),
              children: [
                TextSpan(
                  text: widget.content,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.maintext,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
