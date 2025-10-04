import 'package:flutter/material.dart';

class HealthInfo extends StatelessWidget {
  final String title;
  final String value;

  const HealthInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}
