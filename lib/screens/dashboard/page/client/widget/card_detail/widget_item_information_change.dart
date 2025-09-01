import 'package:exchange_book/screens/dashboard/page/client/cubit/card_detail/card_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../widget/card/card_item_image.dart';

class WidgetItemInformationChange extends StatefulWidget {
  final List<dynamic> item;
  final Widget widgetButton;
  const WidgetItemInformationChange(
      {super.key, required this.item, required this.widgetButton});

  @override
  State<WidgetItemInformationChange> createState() =>
      _WidgetItemInformationChangeState();
}

class _WidgetItemInformationChangeState
    extends State<WidgetItemInformationChange> {
  late CardDetailCubit cardDetailCubit;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    cardDetailCubit = CardDetailCubit();
    cardDetailCubit.loadData(widget.item[7].toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDetailCubit, CardDetailState>(
      bloc: cardDetailCubit,
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;
          final rawImageWidth = isNarrow ? constraints.maxWidth * 0.36 : 220.0;
          final imageWidth = rawImageWidth > 220.0 ? 220.0 : rawImageWidth;
          final imageHeight =
              imageWidth * 1.4; // portrait rectangle to avoid square crop

          // Card-like wrapper for a cleaner look
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.background),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 12,
                        offset: const Offset(0, 6))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image column
                      Container(
                        width: imageWidth,
                        height: imageHeight,
                        margin: EdgeInsets.only(right: isNarrow ? 12 : 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CardItemImage(
                              width: imageWidth,
                              height: imageHeight,
                              borderRadius: 0,
                              link: "$location/${widget.item[6]}",
                              heart: false,
                            )),
                      ),

                      // Info takes remaining space
                      Expanded(
                          child: _infoColumn(context, isNarrow, imageWidth)),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(
                    color: Theme.of(context).dividerColor.withOpacity(0.08),
                    thickness: 1,
                  ),

                  const SizedBox(height: 12),

                  // Seller row (styled)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.98),
                        border: Border.all(
                            color: Theme.of(context)
                                .dividerColor
                                .withOpacity(0.04))),
                    child: Row(children: [
                      CircleAvatar(
                          radius: 28,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundImage: cardDetailCubit.state.pathAva != ""
                              ? NetworkImage(
                                  "$location/${cardDetailCubit.state.pathAva}")
                              : null,
                          child: cardDetailCubit.state.pathAva == ""
                              ? const Icon(Icons.person, color: Colors.white)
                              : null),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                                cardDetailCubit.state.user == null
                                    ? 'Họ và tên'
                                    : cardDetailCubit.state.user!.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            const SizedBox(height: 4),
                            Text(
                                cardDetailCubit.state.user == null
                                    ? 'Email'
                                    : cardDetailCubit.state.user!.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.black54)),
                          ])),
                      const SizedBox(width: 8),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08)),
                          child: Text('Người bán',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)))
                    ]),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoColumn(BuildContext context, bool isNarrow, double imageWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(widget.item[1] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15)),

          const SizedBox(height: 8),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.item[4]} VND',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.primary,
                  fontSize: 15
                    ),
              ),
              const SizedBox(width: 8),
              if ((widget.item[10] ?? 0) is num)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (widget.item[10] ?? 0) > 0
                        ? Colors.green.withOpacity(0.12)
                        : Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    (widget.item[10] ?? 0) > 0
                        ? 'Còn ${(widget.item[10] as num).toInt()}'
                        : 'Hết hàng',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: (widget.item[10] ?? 0) > 0
                              ? Colors.green[800]
                              : Colors.red[800],
                        ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),
          // Info chips
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              Chip(
                visualDensity: VisualDensity.compact,
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.08),
                label: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.category,
                      size: 14, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(widget.item[2]?.toString() ?? '')
                ]),
              ),
              Chip(
                visualDensity: VisualDensity.compact,
                backgroundColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.06),
                label: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.calendar_today,
                      size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text(widget.item[3]?.toString() ?? '')
                ]),
              ),
              Chip(
                visualDensity: VisualDensity.compact,
                backgroundColor: Colors.grey.withOpacity(0.06),
                label: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.info, size: 14, color: Colors.black54),
                  const SizedBox(width: 6),
                  Text('SKU: ${widget.item[7]?.toString() ?? ''}')
                ]),
              ),
            ],
          ),

          const SizedBox(height: 10),
          Builder(builder: (c) {
            final full = "${widget.item[5]}".trim();
            final preview = full.split('\n').take(3).join('\n');
            final showFull = _expanded || full.length <= preview.length;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(showFull ? full : preview,
                    style: Theme.of(context).textTheme.bodyMedium),
                if (full.length > preview.length)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      child: Text(_expanded ? 'Thu gọn' : 'Xem thêm'),
                    ),
                  )
              ],
            );
          }),

          const SizedBox(height: 12),

          // Action button from parent: full-width on narrow screens
          isNarrow
              ? SizedBox(width: double.infinity, child: widget.widgetButton)
              : widget.widgetButton,
        ],
      ),
    );
  }
}
