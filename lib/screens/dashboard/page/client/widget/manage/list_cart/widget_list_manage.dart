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
    final cs = Theme.of(context).colorScheme;
    final count = widget.list.length;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cs.primary.withOpacity(0.08),
                  cs.primary.withOpacity(0.02),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.primary.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.list_alt_rounded, color: cs.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Danh sách đơn hàng',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: cs.primary.withOpacity(0.25), blurRadius: 6, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Text('$count',
                      style: TextStyle(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      )),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          if (count == 0) ...[
            // Empty state
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.06),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.inbox_outlined,
                        size: 44,
                        color: cs.onSurface.withOpacity(0.3)),
                  ),
                  const SizedBox(height: 16),
                  Text('Không có đơn hàng nào',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: cs.onSurface.withOpacity(0.5),
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 6),
                  Text('Các đơn hàng sẽ hiển thị tại đây',
                      style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withOpacity(0.35))),
                ],
              ),
            )
          ] else ...[
            // List of items
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
