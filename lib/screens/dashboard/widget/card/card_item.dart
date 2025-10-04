import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import 'card_item_image.dart';

class CardItem extends StatefulWidget {
  final Widget body;
  final double width;
  final bool heart;
  final String link;
  const CardItem({
    super.key,
    required this.body,
    required this.width,
    required this.heart,
    required this.link,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double maxWidth = MediaQuery.of(context).size.width - 32;
    final double cardWidth = widget.width.isFinite ? widget.width : maxWidth;
    final double radius = 16.0;
    final double imageHeight = cardWidth * 0.65;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: _isHovered ? Colors.blue.shade200 : Colors.blue.shade100,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? Colors.blue.withOpacity(0.15)
                      : Colors.blue.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: _isHovered ? 20 : 12,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius - 1),
                    topRight: Radius.circular(radius - 1),
                  ),
                  child: CardItemImage(
                    width: cardWidth,
                    height: imageHeight,
                    borderRadius: radius - 1,
                    heart: widget.heart,
                    link: widget.link,
                  ),
                ),

                // Content section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.blue.shade800,
                        ) ??
                        TextStyle(color: Colors.blue.shade800),
                    child: widget.body,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
