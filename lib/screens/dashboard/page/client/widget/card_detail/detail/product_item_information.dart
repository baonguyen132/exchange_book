import 'package:flutter/material.dart';

class ProductItemInformation extends StatefulWidget {
  final List<dynamic> item;
  const ProductItemInformation({super.key, required this.item});

  @override
  State<ProductItemInformation> createState() => _ProductItemInformationState();
}

class _ProductItemInformationState extends State<ProductItemInformation> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final title =
        widget.item.length > 1 ? (widget.item[1]?.toString() ?? '') : '';
    final desc =
        widget.item.length > 5 ? (widget.item[5]?.toString() ?? '') : '';
    final qty =
        widget.item.length > 10 ? widget.item[10]?.toString() ?? '' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: -0.2,
            ),
          ),

          if (desc.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurface.withOpacity(0.55),
                height: 1.4,
              ),
            ),
          ],

          const SizedBox(height: 6),

          // quantity chip
          if (qty.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 12, color: cs.primary),
                  const SizedBox(width: 5),
                  Text(
                    'Còn: $qty',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
