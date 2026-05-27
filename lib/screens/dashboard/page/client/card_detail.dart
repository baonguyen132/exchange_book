import 'package:exchange_book/screens/dashboard/page/client/widget/card_detail/detail/widget_button_card_detail_of_product.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/card_detail/detail/widget_item_product.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/card_detail/widget_item_information_change.dart';
import 'package:flutter/material.dart';

import '../../../../data/ConstraintData.dart';
import '../../../../model/book_modal.dart';
import '../../../../model/detail_cart_modal.dart';

class CardDetail extends StatefulWidget {
  final List<dynamic> item;
  final List<dynamic> list;

  const CardDetail({super.key, required this.item, required this.list, });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final isNarrow = width < 900;
    final rightWidth = (width * 0.32).clamp(300.0, 420.0);

    // Build the list widget once
    final builtList = Column(
      children: List.generate(
        widget.list.length,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i == widget.list.length - 1 ? 0 : 8),
          child: WidgetItemProduct(
            width: double.infinity,
            item: widget.list[i],
            openItem: (item) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardDetail(item: item, list: widget.list),));
            },
          ),
        ),
      ),
    );

    // Product list card builder
    Widget buildListCard() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? cs.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: cs.onSurface.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.list_alt_rounded, color: cs.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text('Danh sách sản phẩm',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: cs.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('${widget.list.length}',
                      style: TextStyle(color: cs.onPrimary, fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(height: 1, color: cs.onSurface.withOpacity(0.06)),
            const SizedBox(height: 14),
            builtList
          ],
        ),
      );
    }

    // Detail button builder
    Widget buildDetailButton() {
      return WidgetButtonCardDetailOfProduct(change: () {
        toast("Đã thêm vào giỏ hàng");

        final detailCart = DetailCartModal(
          bookModal: BookModal(
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
          quantity: 1,
          nameBook: widget.item[1].toString(),
        );

        DetailCartModal.saveDetail(
          widget.item[0].toString(),
          widget.item[7].toString(),
          detailCart,
        );
      });
    }

    return Scaffold(
      backgroundColor: isDark ? cs.background : const Color(0xFFF7F8FC),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: cs.primary,
        tooltip: 'Quay lại',
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WidgetItemInformationChange(
                      item: widget.item,
                      widgetButton: buildDetailButton(),
                    ),
                    const SizedBox(height: 20),
                    buildListCard(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: WidgetItemInformationChange(
                          item: widget.item,
                          widgetButton: buildDetailButton(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: rightWidth,
                      child: buildListCard(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
