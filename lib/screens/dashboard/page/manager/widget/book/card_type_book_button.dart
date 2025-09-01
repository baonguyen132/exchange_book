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
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        transform: Matrix4.identity()..scale(_hover ? 1.06 : 1.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.color.withOpacity(0.14),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: _hover
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ]
              : null,
        ),
        child: Material(
          color: _hover ? widget.color.withOpacity(0.08) : Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () => widget.handle(),
            customBorder: const CircleBorder(),
            splashColor: widget.color.withOpacity(0.12),
            child: Center(
              child: Icon(
                widget.iconData,
                color: widget.color,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
