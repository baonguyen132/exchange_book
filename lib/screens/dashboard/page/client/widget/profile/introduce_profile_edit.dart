import 'package:flutter/material.dart';

class IntroduceProfileEdit extends StatefulWidget {
  final Function() handle;
  const IntroduceProfileEdit({super.key, required this.handle});

  @override
  State<IntroduceProfileEdit> createState() => _IntroduceProfileEditState();
}

class _IntroduceProfileEditState extends State<IntroduceProfileEdit> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.handle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? colorScheme.primary : colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_outlined,
                color: _isHovered ? Colors.white : colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 10),
              Text(
                "Chỉnh sửa thông tin",
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _isHovered ? Colors.white : colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

