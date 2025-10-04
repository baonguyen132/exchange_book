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
    final title = widget.item.length > 7 ? widget.item[7].toString() : '';
    final quantity = widget.item.length > 1 ? widget.item[1].toString() : '0';
    final price = (widget.item.length > 4 && widget.item[4] is num)
        ? widget.item[4] as num
        : (widget.item.length > 4
            ? num.tryParse(widget.item[4].toString()) ?? 0
            : 0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 6,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CardItemImage(
                width: 92,
                height: 120,
                borderRadius: 8,
                heart: false,
                link: widget.item.length > 6
                    ? "$location/${widget.item[6]}"
                    : "$location/",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text('Số lượng: $quantity',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Text(
                      'Tổng: ${(price * (num.tryParse(quantity) ?? 0)).toString()} VND',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
