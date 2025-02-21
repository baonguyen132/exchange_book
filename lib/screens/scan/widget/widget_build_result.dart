import 'package:flutter/material.dart';

class WidgetBuildResult extends StatelessWidget {
  const WidgetBuildResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius:  BorderRadius.all(Radius.circular(8))
      ),
      child: const Text(
        "Scan a code!",
        maxLines: 3,
      ),
    );
  }
}
