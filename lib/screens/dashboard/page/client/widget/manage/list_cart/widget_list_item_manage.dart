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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit, ListItemState>(
      bloc: listItemCubit,
      builder: (context, state) {
        final title = widget.item.length > 4 ? widget.item[4].toString() : '';
        final address = widget.item.length > 2 ? widget.item[2].toString() : '';
        final total = widget.item.length > 3 && widget.item[3] != null
            ? widget.item[3].toString()
            : '0';
        final statusText = listItemCubit.state.stateItem;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // Almost-white background with a very pale blue tint at bottom-right
            color: Colors.white,
            gradient: RadialGradient(
              center: const Alignment(0.95, 0.95), // bottom-right
              radius: 0.6,
              colors: [
                Colors.white,
                Theme.of(context).colorScheme.primary.withOpacity(0.06),
              ],
              stops: const [0.92, 1.0],
            ),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.03)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 1.5)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with left accent and title
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.18),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title.isNotEmpty ? 'Tên: $title' : 'Không có tên',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(statusText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),

              // Divider
              Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).dividerColor.withOpacity(0.06)),

              // Items
              Column(
                children:
                    List.generate(listItemCubit.state.listItem.length, (i) {
                  return Column(
                    children: [
                      WidgetItemManage(item: listItemCubit.state.listItem[i]),
                      if (i != listItemCubit.state.listItem.length - 1)
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context)
                                .dividerColor
                                .withOpacity(0.04)),
                    ],
                  );
                }),
              ),

              // Footer: address + total + action
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Địa chỉ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7))),
                          const SizedBox(height: 4),
                          Text(address,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Tổng',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7))),
                        const SizedBox(height: 4),
                        Text('$total VND',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const SizedBox(width: 12),
                    // Action button
                    if ((widget.stateButton == 2 &&
                            widget.item[1] == "Đã xác nhận" &&
                            !listItemCubit.state.stateClick) ||
                        (widget.stateButton == 1 &&
                            widget.item[1] == "Đã chuyển" &&
                            !listItemCubit.state.stateClick))
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!listItemCubit.state.stateClick) {
                              widget.handleClick(
                                  widget.item[0].toString(), widget.item[3]);
                              if (widget.item[1] == "Đã xác nhận") {
                                listItemCubit.exchangeState("Đã chuyển");
                              } else if (widget.item[1] == "Đã chuyển") {
                                listItemCubit.exchangeState("Đã nhận");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                          ),
                          child: Text(widget.textButton,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.w700)),
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
