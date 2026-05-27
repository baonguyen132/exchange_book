import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/list_item_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/list_cart/widget_item_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetListItemManage extends StatefulWidget {
  final List<dynamic> item;
  final String textButton;
  final Function(String idCart, int total) handleClick;
  final int stateButton;
  const WidgetListItemManage({
    super.key,
    required this.item,
    required this.textButton,
    required this.handleClick,
    required this.stateButton,
  });

  @override
  State<WidgetListItemManage> createState() => _WidgetListItemManageState();
}

class _WidgetListItemManageState extends State<WidgetListItemManage> {
  late ListItemCubit listItemCubit;

  @override
  void initState() {
    super.initState();
    listItemCubit = ListItemCubit();
    listItemCubit.loadData(widget.item[0].toString(), widget.item[1]);
  }

  Color _statusColor(String status, ColorScheme cs) {
    switch (status) {
      case 'Đã nhận':
        return Colors.green;
      case 'Đang giao':
        return Colors.orange;
      case 'Xác nhận đơn':
        return cs.primary;
      default:
        return cs.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ListItemCubit, ListItemState>(
      bloc: listItemCubit,
      builder: (context, state) {
        final title = widget.item.length > 4 ? widget.item[4].toString() : '';
        final address = widget.item.length > 2 ? widget.item[2].toString() : '';
        final total = widget.item.length > 3 && widget.item[3] != null ? widget.item[3].toString() : '0';
        final statusText = listItemCubit.state.stateItem;
        final statusClr = _statusColor(statusText, cs);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? cs.surface : Colors.white,
            border: Border.all(color: cs.onSurface.withOpacity(0.06)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primary.withOpacity(0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.receipt_long_rounded, color: cs.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title.isNotEmpty ? title : 'Không có tên',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusClr.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusClr.withOpacity(0.25)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(color: statusClr, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(statusText,
                              style: TextStyle(fontSize: 12, color: statusClr, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Items
              Column(
                children: List.generate(listItemCubit.state.listItem.length, (i) {
                  return Column(
                    children: [
                      WidgetItemManage(item: listItemCubit.state.listItem[i]),
                      if (i != listItemCubit.state.listItem.length - 1)
                        Divider(height: 1, thickness: 1, indent: 14, endIndent: 14, color: cs.onSurface.withOpacity(0.05)),
                    ],
                  );
                }),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  color: cs.primary.withOpacity(0.03),
                ),
                child: Row(
                  children: [
                    // Address
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 14, color: cs.onSurface.withOpacity(0.5)),
                              const SizedBox(width: 4),
                              Text('Địa chỉ', style: TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.55), fontWeight: FontWeight.w500)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(address, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Total
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Tổng', style: TextStyle(fontSize: 12, color: cs.onSurface.withOpacity(0.55), fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text('$total VND', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: cs.primary)),
                      ],
                    ),
                    const SizedBox(width: 14),
                    // Action button
                    if ((widget.stateButton == 2 && widget.item[1] == "Xác nhận đơn" && !listItemCubit.state.stateClick) ||
                        (widget.stateButton == 1 && widget.item[1] == "Đang giao" && !listItemCubit.state.stateClick))
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!listItemCubit.state.stateClick) {
                              widget.handleClick(widget.item[0].toString(), widget.item[3]);
                              if (widget.item[1] == "Xác nhận đơn") {
                                listItemCubit.exchangeState("Đang giao");
                              } else if (widget.item[1] == "Đang giao") {
                                listItemCubit.exchangeState("Đã nhận");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                          ),
                          child: Text(widget.textButton, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
