import 'package:flutter/material.dart';

class TransferButton extends StatefulWidget {
  final Function() handleClick;
  final String title ;
  final IconData icon ;
  const TransferButton({super.key, required this.handleClick, required this.title, required this.icon});

  @override
  State<TransferButton> createState() => _TransferButtonState();
}

class _TransferButtonState extends State<TransferButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          widget.handleClick();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Colors.blue.withOpacity(0.3),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 20),
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
