import 'package:flutter/material.dart';

import '../../../../../../../data/ConstraintData.dart';
import '../../../../../../../theme/theme.dart' as theme;
import '../../../../../widget/card/card_item_image.dart';
import 'product_item_information.dart';

class WidgetItemProduct extends StatefulWidget {
  final double width;
  final List<dynamic> item;
  final Function(List<dynamic> item) openItem;
  const WidgetItemProduct(
      {super.key,
      required this.width,
      required this.item,
      required this.openItem});

  @override
  State<WidgetItemProduct> createState() => _WidgetItemProductState();
}

class _WidgetItemProductState extends State<WidgetItemProduct> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.openItem(widget.item);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          transform:
              _hover ? (Matrix4.identity()..scale(1.02)) : Matrix4.identity(),
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.only(bottom: 14),
          width: widget.width,
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
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.openItem(widget.item),
              borderRadius: BorderRadius.circular(8),
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.08),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // vertical accent bar
                    Container(
                      width: 6,
                      height: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.06),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CardItemImage(
                        width: 100,
                        height: 100,
                        borderRadius: 10,
                        heart: false,
                        link: "$location/${widget.item[6]}",
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Ensure product info text is slightly larger and darker
                          DefaultTextStyle.merge(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 14, color: Colors.black87),
                            child: ProductItemInformation(item: widget.item),
                          ),
                          // footer: price and small action hint
                          Row(
                            children: [
                              Text('${widget.item[4]} VND',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.6))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
