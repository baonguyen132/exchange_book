import 'dart:math';
import 'package:flutter/material.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../../../model/book_modal.dart';
import '../../../../widget/card/card_item_image.dart';

class BestItem extends StatefulWidget {
  final List<dynamic> item;
  final Function(List<dynamic> item) openItem;
  final Function(BookModal bookModal, String nameBook) order;

  const BestItem(
      {super.key,
      required this.item,
      required this.openItem,
      required this.order});

  @override
  State<BestItem> createState() => _BestItemState();
}

class _BestItemState extends State<BestItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final priceRaw = widget.item[4]?.toString() ?? '';
    final priceLabel = priceRaw.isNotEmpty ? '$priceRaw ₫' : '';

    return GestureDetector(
      onTap: () => widget.openItem(widget.item),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          width: min(MediaQuery.of(context).size.width, 520),
          transform: _hover
              ? (Matrix4.identity()..scale(1.015, 1.015))
              : Matrix4.identity(),
          transformAlignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isDark ? cs.surface : Colors.white,
            border: Border.all(
              color: _hover ? cs.primary.withOpacity(0.25) : cs.onSurface.withOpacity(0.06),
              width: _hover ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(_hover ? 0.10 : 0.0),
                blurRadius: _hover ? 20 : 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(_hover ? 0.07 : 0.03),
                offset: Offset(0, _hover ? 8 : 3),
                blurRadius: _hover ? 16 : 8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Subtle gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cs.primary.withOpacity(0.03),
                          Colors.transparent,
                          cs.primary.withOpacity(0.02),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Accent bar
                      Container(
                        width: 3,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [cs.primary, cs.primary.withOpacity(0.3)],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Image with shadow
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              offset: const Offset(2, 3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CardItemImage(
                            width: 80,
                            height: 80,
                            borderRadius: 12,
                            heart: false,
                            link: "$location/${widget.item[6]}",
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Main info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title + price row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.item[1]?.toString() ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Price badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: cs.primary.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    priceLabel,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: cs.primary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Description
                            Text(
                              widget.item[5]?.toString() ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: cs.onSurface.withOpacity(0.55),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Buttons row
                            Row(
                              children: [
                                const Spacer(),
                                // View button
                                SizedBox(
                                  height: 34,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: cs.primary.withOpacity(0.08),
                                      foregroundColor: cs.primary,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 0,
                                    ),
                                    onPressed: () => widget.openItem(widget.item),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.visibility_outlined, size: 15, color: cs.primary),
                                        const SizedBox(width: 6),
                                        Text('Xem', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.primary)),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Buy button
                                SizedBox(
                                  height: 34,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: cs.primary,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed: () {
                                      widget.order(
                                        BookModal(
                                          id: widget.item[0].toString(),
                                          date_purchase: widget.item[3],
                                          price: widget.item[4].toString(),
                                          description: widget.item[5],
                                          status: widget.item[9].toString(),
                                          image: widget.item[6],
                                          quantity: widget.item[10].toString(),
                                          id_user: widget.item[7].toString(),
                                          id_type_book: widget.item[8].toString(),
                                        ),
                                        widget.item[1].toString(),
                                      );
                                    },
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.shopping_cart_outlined, size: 15, color: Colors.white),
                                        SizedBox(width: 6),
                                        Text('Mua', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                                      ],
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
