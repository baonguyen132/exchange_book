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
    final title =
        widget.item.length > 1 ? (widget.item[1]?.toString() ?? '') : '';
    final desc =
        widget.item.length > 5 ? (widget.item[5]?.toString() ?? '') : '';
    final qty =
        widget.item.length > 10 ? widget.item[10]?.toString() ?? '' : '';
    final price =
        widget.item.length > 4 ? widget.item[4]?.toString() ?? '' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title row
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black87,
                fontSize: 14
            ),
          ),

          if (desc.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
          ],

          const SizedBox(height: 4),

          // quantity / meta row
          Row(
            children: [
              if (qty.isNotEmpty)
                Text(
                  'Còn: $qty',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.black54),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
