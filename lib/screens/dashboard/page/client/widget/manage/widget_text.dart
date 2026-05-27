import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class WidgetText extends StatefulWidget {

  final IconData icon ;
  final String title , content ;

  const WidgetText({super.key , required this.icon , required this.title , required this.content});

  @override
  State<WidgetText> createState() => _WidgetTextState();
}

class _WidgetTextState extends State<WidgetText> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              size: 16,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              text: TextSpan(
                text: "${widget.title}: ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.maintext,
                  decoration: TextDecoration.none,
                  letterSpacing: -0.2,
                  height: 1.6,
                ),
                children: [
                  TextSpan(
                    text: widget.content,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.maintext.withOpacity(0.75),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
