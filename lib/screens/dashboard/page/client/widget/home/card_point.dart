import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CardPoint extends StatelessWidget {
  final String barcode;
  final String point;
  const CardPoint({super.key, required this.barcode, required this.point});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    // mix primary with white to get a very pale blue
    final Color paleBlue = Color.lerp(theme.primaryColor, Colors.white, 0.82) ??
        theme.primaryColor.withOpacity(0.18);
    final Color cardEnd = paleBlue.withOpacity(0.6);

    return Container(
      width: width,
      // Provide a bounded height so children using Expanded/Flexible can layout
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // mostly white with a soft blue tint towards the bottom-right
        gradient: LinearGradient(
          colors: [Colors.white, cardEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          // subtle cool-blue glow
          BoxShadow(
            color: paleBlue.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
          // soft neutral shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thẻ điểm',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mã khách hàng',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  // Points pill
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue
                          .withOpacity(0.08), // soft blue translucent pill
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          point,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Barcode box
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints:
                        BoxConstraints(maxWidth: width * 0.9, maxHeight: 120),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.96), // slightly translucent white
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: paleBlue.withOpacity(0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: paleBlue.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: BarcodeWidget(
                            data: barcode.isNotEmpty ? barcode : '0000000000',
                            barcode: Barcode.code128(),
                            drawText: false,
                            width: double.infinity,
                            height: double.infinity,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          barcode,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
