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
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priceRaw = widget.item[4]?.toString() ?? '';
    final priceLabel = priceRaw.isNotEmpty ? '$priceRaw ₫' : '';
    final status = widget.item[9]?.toString() ?? '';
    final isAvailable = status == '1' || status.toLowerCase() == 'available';

    return GestureDetector(
      onTap: () => widget.openItem(widget.item),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: min(MediaQuery.of(context).size.width, 520),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // subtle primary-tinted border for cohesion with gradient
            border: Border.all(
                color: theme.primaryColor.withOpacity(0.08), width: 1),
            gradient: LinearGradient(
              begin: const Alignment(-0.9, -0.6),
              end: const Alignment(0.9, 0.8),
              colors: [
                Colors.white,
                theme.primaryColor.withOpacity(0.06),
                theme.primaryColor.withOpacity(0.03),
              ],
              stops: const [0.0, 0.55, 1.0],
              tileMode: TileMode.clamp,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: const Offset(0, 6),
                blurRadius: 18,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // image with subtle border
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CardItemImage(
                    width: 80,
                    height: 80,
                    borderRadius: 8,
                    heart: false,
                    link: "$location/${widget.item[6]}",
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // main info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.item[1]?.toString() ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // inline price
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            priceLabel,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.item[5]?.toString() ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Spacer(),
                        // show/detail button
                        SizedBox(
                          height: 36,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => widget.openItem(widget.item),
                            icon:
                                const Icon(Icons.visibility_outlined, size: 16),
                            label: const Text('Xem',
                                style: TextStyle(fontSize: 13)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // primary action
                        SizedBox(
                          height: 36,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                            icon: const Icon(Icons.shopping_cart_outlined,
                                size: 16, color: Colors.white),
                            label: const Text(
                                'Mua',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white
                                )
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
      ),
    );
  }
}
