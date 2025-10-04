import 'package:flutter/material.dart';

class CardItemText extends StatefulWidget {
  final String text;
  final FontWeight fontWeight;

  const CardItemText({super.key, required this.text, required this.fontWeight});

  @override
  State<CardItemText> createState() => _CardItemTextState();
}

class _CardItemTextState extends State<CardItemText> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.textTheme.bodyLarge?.color ?? Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: widget.fontWeight,
          color: color,
          decoration: TextDecoration.none,
          height: 1.2,
        ),
      ),
    );
  }
}
