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

  int tinhtuoisach(String tuoi)
  {
    DateTime ngayMua = DateTime.parse(tuoi);
    DateTime hienTai = DateTime.now();

    // Tính số năm tuổi sách
    int tuoiSach = hienTai.year - ngayMua.year;
    if (hienTai.month < ngayMua.month ||
        (hienTai.month == ngayMua.month && hienTai.day < ngayMua.day)) {
      tuoiSach--; // chưa tới ngày kỷ niệm => trừ đi 1
    }

    return tuoiSach ;
  }


  @override
  void initState() {
    super.initState();
    cardDetailCubit = CardDetailCubit();
    cardDetailCubit.loadData(widget.item[7].toString());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<CardDetailCubit, CardDetailState>(
      bloc: cardDetailCubit,
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;
          final rawImageWidth = isNarrow ? constraints.maxWidth * 0.36 : 220.0;
          final imageWidth = rawImageWidth > 220.0 ? 220.0 : rawImageWidth;
          final imageHeight = imageWidth * 1.4;

          return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? cs.surface : const Color(0xFFF7F8FC)),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: isDark ? cs.surface : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: cs.onSurface.withOpacity(0.06)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 6))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with shadow
                      Container(
                        width: imageWidth,
                        height: imageHeight,
                        margin: EdgeInsets.only(right: isNarrow ? 14 : 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 12,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: CardItemImage(
                              width: imageWidth,
                              height: imageHeight,
                              borderRadius: 0,
                              link: "$location/${widget.item[6]}",
                              heart: false,
                            )),
                      ),

                      // Info
                      Expanded(
                          child: _infoColumn(context, isNarrow, imageWidth)),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(color: cs.onSurface.withOpacity(0.06), thickness: 1),
                  const SizedBox(height: 16),

                  // Seller section
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cs.primary.withOpacity(0.06),
                          cs.primary.withOpacity(0.02),
                        ],
                      ),
                      border: Border.all(color: cs.primary.withOpacity(0.08)),
                    ),
                    child: Row(children: [
                      // Avatar with ring
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: cs.primary.withOpacity(0.3), width: 2),
                        ),
                        child: CircleAvatar(
                            radius: 24,
                            backgroundColor: cs.primary.withOpacity(0.15),
                            backgroundImage: cardDetailCubit.state.pathAva != ""
                                ? NetworkImage(
                                    "$location/${cardDetailCubit.state.pathAva}")
                                : null,
                            child: cardDetailCubit.state.pathAva == ""
                                ? Icon(Icons.person, color: cs.primary, size: 22)
                                : null),
                      ),
                      const SizedBox(width: 14),
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
                                        color: cs.primary,
                                        letterSpacing: -0.2)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.email_outlined, size: 14, color: cs.onSurface.withOpacity(0.45)),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                      cardDetailCubit.state.user == null
                                          ? 'Email'
                                          : cardDetailCubit.state.user!.email,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurface.withOpacity(0.55))),
                                ),
                              ],
                            ),
                          ])),
                      const SizedBox(width: 8),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: cs.primary.withOpacity(0.12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.storefront_rounded, size: 14, color: cs.primary),
                              const SizedBox(width: 6),
                              Text('Người bán',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: cs.primary, fontWeight: FontWeight.w600)),
                            ],
                          ))
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
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 0 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(widget.item[1] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                  fontSize: 17,
                  letterSpacing: -0.3)),

          const SizedBox(height: 10),

          // Price row
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${widget.item[4]} VND',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: cs.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              if ((widget.item[10] ?? 0) is num)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: (widget.item[10] ?? 0) > 0
                        ? Colors.green.withOpacity(0.10)
                        : Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        (widget.item[10] ?? 0) > 0 ? Icons.check_circle_outline : Icons.remove_circle_outline,
                        size: 14,
                        color: (widget.item[10] ?? 0) > 0 ? Colors.green[700] : Colors.red[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (widget.item[10] ?? 0) > 0
                            ? 'Còn ${(widget.item[10] as num).toInt()}'
                            : 'Hết hàng',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: (widget.item[10] ?? 0) > 0 ? Colors.green[700] : Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          // Info chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(context, Icons.category_rounded, widget.item[2]?.toString() ?? '', cs.primary.withOpacity(0.08), cs.primary),
              _buildChip(context, Icons.access_time_rounded, "Tuổi: ${tinhtuoisach(widget.item[3] ?? '2000-01-01')} năm", cs.onSurface.withOpacity(0.06), cs.onSurface.withOpacity(0.7)),
            ],
          ),

          const SizedBox(height: 14),

          // Description
          Builder(builder: (c) {
            final full = "${widget.item[5]}".trim();
            final preview = full.split('\n').take(3).join('\n');
            final showFull = _expanded || full.length <= preview.length;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.onSurface.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(showFull ? full : preview,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
                ),
                if (full.length > preview.length)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: TextButton.icon(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      icon: Icon(_expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18),
                      label: Text(_expanded ? 'Thu gọn' : 'Xem thêm', style: const TextStyle(fontSize: 13)),
                    ),
                  )
              ],
            );
          }),

          const SizedBox(height: 14),

          // Action button
          isNarrow
              ? SizedBox(width: double.infinity, child: widget.widgetButton)
              : widget.widgetButton,
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, IconData icon, String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: fg)),
        ],
      ),
    );
  }
}
