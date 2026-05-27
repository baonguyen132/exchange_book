import 'package:flutter/material.dart';

class ScheduleCard extends StatefulWidget {
  final String title;
  final String time;

  const ScheduleCard({super.key, required this.title, required this.time});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        transform: Matrix4.identity()..scale(_hover ? 1.015 : 1.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hover
                ? theme.primaryColor.withOpacity(0.3)
                : (isDark ? Colors.white10 : Colors.black.withOpacity(0.04)),
          ),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? theme.primaryColor.withOpacity(0.08)
                  : Colors.black.withOpacity(isDark ? 0.2 : 0.06),
              blurRadius: _hover ? 12 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.primaryColor,
                    theme.primaryColor.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.time,
                    style: TextStyle(color: subtextColor, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.more_horiz, color: subtextColor, size: 20),
          ],
        ),
      ),
    );
  }
}
