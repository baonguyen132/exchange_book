import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import 'card_item_image.dart';

class CardItem extends StatefulWidget {
  final Widget body;
  final double width;
  final bool heart;
  final String link;
  const CardItem(
      {super.key,
      required this.body,
      required this.width,
      required this.heart,
      required this.link});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double maxWidth =
        MediaQuery.of(context).size.width - 24; // leave small side margin
    final double cardWidth = widget.width.isFinite ? widget.width : maxWidth;
    final double radius = 18.0;
    final double imageHeight = cardWidth * 0.56;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // lifted image block
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(radius - 4),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: cardWidth,
                    height: imageHeight,
                    child: CardItemImage(
                      width: cardWidth,
                      height: imageHeight,
                      borderRadius: radius - 4,
                      heart: widget.heart,
                      link: widget.link,
                    ),
                  ),
                ),
              ),

              // body area with padding and subtle divider
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(radius - 4)),
                ),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium ??
                      const TextStyle(),
                  child: widget.body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
