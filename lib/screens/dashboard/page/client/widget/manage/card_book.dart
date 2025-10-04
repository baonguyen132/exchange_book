import 'package:flutter/material.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../widget/card/card_item_image.dart';

class CardBook extends StatefulWidget {
  final String link;
  final Widget child;
  final double width;

  const CardBook(
      {super.key,
      required this.width,
      required this.link,
      required this.child});

  @override
  State<CardBook> createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          // use surface color to keep card bright and readable; slightly lifted with a subtle gradient
          color: Theme.of(context).colorScheme.surface,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
            ],
          ),
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hover ? 0.06 : 0.02),
              offset: Offset(0, _hover ? 6 : 3),
              blurRadius: _hover ? 10 : 6,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CardItemImage(
                width: 96,
                height: 128,
                borderRadius: 8,
                heart: false,
                link: "$location/${widget.link}",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium ??
                    const TextStyle(fontSize: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // keep user's provided child but ensure spacing is tidy if it's a Column
                    SizedBox(
                      width: double.infinity,
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
