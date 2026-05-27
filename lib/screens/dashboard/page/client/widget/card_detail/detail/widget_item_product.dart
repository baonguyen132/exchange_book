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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        widget.openItem(widget.item);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform:
              _hover ? (Matrix4.identity()..scale(1.015)) : Matrix4.identity(),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.only(bottom: 10),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: isDark ? cs.surface : Colors.white,
            border: Border.all(
              color: _hover ? cs.primary.withOpacity(0.20) : cs.onSurface.withOpacity(0.06),
              width: _hover ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(_hover ? 0.08 : 0.0),
                blurRadius: _hover ? 16 : 0,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(_hover ? 0.06 : 0.03),
                offset: Offset(0, _hover ? 6 : 2),
                blurRadius: _hover ? 14 : 8,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.openItem(widget.item),
              borderRadius: BorderRadius.circular(14),
              splashColor: cs.primary.withOpacity(0.06),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // accent bar
                    Container(
                      width: 3,
                      height: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [cs.primary, cs.primary.withOpacity(0.3)],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),

                    // Image with shadow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            offset: const Offset(1, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CardItemImage(
                          width: 88,
                          height: 88,
                          borderRadius: 10,
                          heart: false,
                          link: "$location/${widget.item[6]}",
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultTextStyle.merge(
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                            child: ProductItemInformation(item: widget.item),
                          ),
                          // footer: price
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: cs.primary.withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('${widget.item[4]} VND',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: cs.primary)),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: cs.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14, color: cs.primary),
                              ),
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
