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
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_hover ? 1.015 : 1.0),
        width: MediaQuery.of(context).size.width < 650
            ? MediaQuery.of(context).size.width
            : 400,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: _hover ? 6 : 2,
          shadowColor: _hover
              ? theme.primaryColor.withOpacity(0.15)
              : Colors.black.withOpacity(isDark ? 0.3 : 0.1),
          color: cardColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _hover
                      ? theme.primaryColor.withOpacity(0.2)
                      : (isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04)),
                ),
              ),
              padding: const EdgeInsets.all(14),
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
                        // Type badge chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            widget.typeBookModal.type_book,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.typeBookModal.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: subtextColor),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (widget.typeBookModal.price.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.primaryColor.withOpacity(isDark ? 0.15 : 0.10),
                                      theme.primaryColor.withOpacity(isDark ? 0.08 : 0.04),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${widget.typeBookModal.price} đ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),

                            const SizedBox(width: 8),

                            // small muted meta
                            Text(
                              'ID: ${widget.typeBookModal.id}',
                              style: TextStyle(
                                fontSize: 11,
                                color: subtextColor.withOpacity(0.7),
                              ),
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
      ),
    );
  }
}
