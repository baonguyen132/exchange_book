import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItemImage extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  final String link;

  final bool heart;
  const CardItemImage(
      {super.key,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.heart,
      required this.link});

  @override
  State<CardItemImage> createState() => _CardItemImageState();
}

class _CardItemImageState extends State<CardItemImage> {
  bool clickHeart = false;
  @override
  Widget build(BuildContext context) {
    final double useRadius = min(widget.borderRadius, 6.0);
    final radius = BorderRadius.circular(useRadius);

    return PhysicalModel(
      color: Colors.transparent,
      elevation: 6,
      borderRadius: radius,
      shadowColor: Colors.black.withOpacity(0.08),
      child: ClipRRect(
        borderRadius: radius,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.04)),
            color: Colors.grey.shade100,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // image with loading and error handling
              Image.network(
                widget.link,
                fit: BoxFit.cover,
                width: widget.width,
                height: widget.height,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade100,
                    child: const Center(
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2))),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(Icons.broken_image,
                        color: Colors.grey.shade400, size: 40),
                  ),
                ),
              ),

              // subtle top + bottom gradient for improved contrast
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: (widget.height * 0.18).clamp(18.0, 60.0),
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.06),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: (widget.height * 0.28).clamp(28.0, 80.0),
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.28),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // heart button (top-right) - compact and clearer
              if (widget.heart)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.white.withOpacity(0.95),
                    shape: const CircleBorder(),
                    elevation: 2,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        setState(() {
                          clickHeart = !clickHeart;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.heart_fill,
                          color: clickHeart
                              ? Colors.redAccent
                              : Colors.grey.shade700,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
