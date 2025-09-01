import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/manager/widget/book/card_type_book_button.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/type_book_modal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../widget/card/card_item_image.dart';

class CardTypeBookMobile extends StatefulWidget {
  final TypeBookModal typeBookModal;
  final Function(TypeBookModal typeBookModal) edit;
  final Function(TypeBookModal typeBookModal) delete;

  const CardTypeBookMobile({
    super.key,
    required this.typeBookModal,
    required this.delete,
    required this.edit,
  });

  @override
  State<CardTypeBookMobile> createState() => _CardTypeBookMobileState();
}

class _CardTypeBookMobileState extends State<CardTypeBookMobile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width < 650
          ? MediaQuery.of(context).size.width
          : 400,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        color: theme.colorScheme.mainCard,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image with subtle rounded border
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CardItemImage(
                    width: 110,
                    height: 110,
                    borderRadius: 12,
                    heart: false,
                    link: "$location/${widget.typeBookModal.image}",
                  ),
                ),

                const SizedBox(width: 14),

                // Main content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.typeBookModal.name_book,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.typeBookModal.type_book,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                            fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.typeBookModal.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (widget.typeBookModal.price.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${widget.typeBookModal.price} đ',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.primaryColor),
                              ),
                            ),

                          const SizedBox(width: 8),

                          // small muted meta placeholder
                          Text(
                            'ID: ${widget.typeBookModal.id}',
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Actions (compact)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardTypeBookButton(
                      color: Colors.blue,
                      iconData: Icons.edit,
                      handle: () {
                        widget.edit(widget.typeBookModal);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardTypeBookButton(
                      color: Colors.red,
                      iconData: Icons.close,
                      handle: () {
                        widget.delete(widget.typeBookModal);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
