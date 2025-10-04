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
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.handle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.blue.shade600 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.blue.shade200,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: _isHovered ? Colors.white : Colors.blue.shade600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  "Chỉnh sửa thông tin",
                  style: TextStyle(
                    fontSize: 16,
                    color: _isHovered ? Colors.white : Colors.blue.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
