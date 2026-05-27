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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        width: widget.width,
        transform: _hover
            ? (Matrix4.identity()..scale(1.015, 1.015))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark
              ? colorScheme.surface
              : Colors.white,
          border: Border.all(
            color: _hover
                ? colorScheme.primary.withOpacity(0.25)
                : colorScheme.onSurface.withOpacity(0.06),
            width: _hover ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(_hover ? 0.10 : 0.0),
              offset: const Offset(0, 0),
              blurRadius: _hover ? 20 : 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(_hover ? 0.08 : 0.03),
              offset: Offset(0, _hover ? 8 : 3),
              blurRadius: _hover ? 16 : 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Subtle gradient background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withOpacity(0.03),
                        Colors.transparent,
                        colorScheme.primary.withOpacity(0.02),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left accent bar
                    Container(
                      width: 3,
                      height: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Book image
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            offset: const Offset(2, 3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CardItemImage(
                          width: 96,
                          height: 128,
                          borderRadius: 10,
                          heart: false,
                          link: "$location/${widget.link}",
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
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
            ],
          ),
        ),
      ),
    );
  }
}
