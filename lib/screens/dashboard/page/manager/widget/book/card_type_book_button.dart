import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTypeBookButton extends StatefulWidget {
  final Function() handle;
  final Color color;
  final IconData iconData;
  const CardTypeBookButton({
    super.key,
    required this.color,
    required this.iconData,
    required this.handle,
  });

  @override
  State<CardTypeBookButton> createState() => _CardTypeBookButtonState();
}

class _CardTypeBookButtonState extends State<CardTypeBookButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 44,
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        transform: Matrix4.identity()..scale(_hover ? 1.1 : 1.0),
        decoration: BoxDecoration(
          color: _hover
              ? widget.color.withOpacity(isDark ? 0.18 : 0.10)
              : (isDark ? Colors.white.withOpacity(0.04) : Colors.transparent),
          border: Border.all(
            width: 1.5,
            color: _hover
                ? widget.color.withOpacity(0.4)
                : widget.color.withOpacity(isDark ? 0.2 : 0.14),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () => widget.handle(),
            customBorder: const CircleBorder(),
            splashColor: widget.color.withOpacity(0.15),
            child: Center(
              child: Icon(
                widget.iconData,
                color: widget.color,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
