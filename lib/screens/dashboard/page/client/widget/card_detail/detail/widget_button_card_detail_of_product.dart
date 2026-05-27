import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class WidgetButtonCardDetailOfProduct extends StatefulWidget {
  final Function () change ;
  const WidgetButtonCardDetailOfProduct({super.key , required this.change});

  @override
  State<WidgetButtonCardDetailOfProduct> createState() => _WidgetButtonCardDetailOfProductState();
}

class _WidgetButtonCardDetailOfProductState extends State<WidgetButtonCardDetailOfProduct> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {print("i") ; widget.change() ;},
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: MediaQuery.of(context).size.width < 500 ? MediaQuery.of(context).size.width : 180,
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 14),
          transform: _pressed
              ? (Matrix4.identity()..scale(0.96, 0.96))
              : _hover
                  ? (Matrix4.identity()..scale(1.02, 1.02))
                  : Matrix4.identity(),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cs.primary,
                cs.primary.withOpacity(0.82),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(_hover ? 0.35 : 0.20),
                blurRadius: _hover ? 14 : 8,
                offset: Offset(0, _hover ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.white.withOpacity(0.9)),
              const SizedBox(width: 10),
              const Text(
                "Đặt mua",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
