import 'package:flutter/material.dart';
import '../../../../../../../data/ConstraintData.dart';
import '../../../../../widget/card/card_item_image.dart';

class WidgetItemManage extends StatefulWidget {
  final List<dynamic> item;
  const WidgetItemManage({super.key, required this.item});

  @override
  State<WidgetItemManage> createState() => _WidgetItemManageState();
}

class _WidgetItemManageState extends State<WidgetItemManage> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final title = widget.item.length > 7 ? widget.item[7].toString() : '';
    final quantity = widget.item.length > 1 ? widget.item[1].toString() : '0';
    final price = (widget.item.length > 4 && widget.item[4] is num)
        ? widget.item[4] as num
        : (widget.item.length > 4
            ? num.tryParse(widget.item[4].toString()) ?? 0
            : 0);
    final total = price * (num.tryParse(quantity) ?? 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? cs.surface : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.onSurface.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book image with shadow
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CardItemImage(
                  width: 80,
                  height: 108,
                  borderRadius: 10,
                  heart: false,
                  link: widget.item.length > 6
                      ? "$location/${widget.item[6]}"
                      : "$location/",
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        letterSpacing: -0.2),
                  ),
                  const SizedBox(height: 10),
                  // Quantity chip
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_bag_outlined,
                                size: 14, color: cs.primary),
                            const SizedBox(width: 6),
                            Text('x$quantity',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: cs.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Total price
                  Row(
                    children: [
                      Icon(Icons.payments_outlined,
                          size: 16,
                          color: cs.onSurface.withOpacity(0.5)),
                      const SizedBox(width: 6),
                      Text(
                        '${total.toString()} VND',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
