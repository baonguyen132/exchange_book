import 'package:flutter/material.dart';
import 'package:exchange_book/model/type_book_modal.dart';

import '../../../../widget/card/card_item_text.dart';


class CardTypeBookInformation extends StatefulWidget {

  final TypeBookModal typeBookModal ;
  const CardTypeBookInformation({super.key , required this.typeBookModal});

  @override
  State<CardTypeBookInformation> createState() => _CardTypeBookInformationState();
}

class _CardTypeBookInformationState extends State<CardTypeBookInformation> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardItemText(text: widget.typeBookModal.name_book, fontWeight: FontWeight.bold),
          const SizedBox(height: 6),
          // Type as a chip-style badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              widget.typeBookModal.type_book,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Price with highlight
          if (widget.typeBookModal.price.isNotEmpty)
            Text(
              '${widget.typeBookModal.price} đ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.greenAccent.shade200 : Colors.green.shade700,
              ),
            ),
          const SizedBox(height: 4),
          Text(
            widget.typeBookModal.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: subtextColor,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
