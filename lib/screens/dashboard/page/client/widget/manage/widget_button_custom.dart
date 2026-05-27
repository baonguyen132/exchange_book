import 'package:flutter/material.dart';

class WidgetButtonCustom extends StatefulWidget {
  final Function () handle ;
  final String text ;
  const WidgetButtonCustom({super.key , required this.handle , required this.text});

  @override
  State<WidgetButtonCustom> createState() => _WidgetButtonCustomState();
}

class _WidgetButtonCustomState extends State<WidgetButtonCustom> {
  bool _hover = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        widget.handle() ;
      },
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
          transform: _pressed
              ? (Matrix4.identity()..scale(0.96, 0.96))
              : _hover
                  ? (Matrix4.identity()..scale(1.02, 1.02))
                  : Matrix4.identity(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withOpacity(0.82),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(_hover ? 0.35 : 0.20),
                  blurRadius: _hover ? 14 : 8,
                  offset: Offset(0, _hover ? 6 : 3),
                ),
              ]
          ),
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.white.withOpacity(0.9),
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
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
