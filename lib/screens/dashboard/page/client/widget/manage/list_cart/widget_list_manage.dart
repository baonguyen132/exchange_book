import 'package:exchange_book/screens/dashboard/page/client/widget/manage/list_cart/widget_list_item_manage.dart';
import 'package:flutter/material.dart';

class WidgetListManage extends StatefulWidget {
  final List<dynamic> list;
  final String textButton;
  final Function(String idCart, int total) handleClick;
  final int stateButton;
  const WidgetListManage(
      {super.key,
      required this.list,
      required this.textButton,
      required this.handleClick,
      required this.stateButton});

  @override
  State<WidgetListManage> createState() => _WidgetListManageState();
}

class _WidgetListManageState extends State<WidgetListManage> {
  @override
  Widget build(BuildContext context) {
    final count = widget.list.length;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with icon and count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.list_alt,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Danh sách sản phẩm',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('$count',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          if (count == 0) ...[
            // Empty state
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined,
                      size: 48,
                      color: Theme.of(context).textTheme.bodySmall?.color),
                  const SizedBox(height: 12),
                  Text('Không có đơn hàng nào',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            )
          ] else ...[
            // List of items
            const SizedBox(height: 6),
            ...List.generate(widget.list.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: WidgetListItemManage(
                  item: widget.list[i],
                  textButton: widget.textButton,
                  stateButton: widget.stateButton,
                  handleClick: (idCart, total) =>
                      widget.handleClick(idCart, total),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
