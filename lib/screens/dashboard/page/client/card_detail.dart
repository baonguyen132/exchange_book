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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Quay lại',
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WidgetItemInformationChange(
                      item: widget.item,
                      widgetButton:
                          WidgetButtonCardDetailOfProduct(change: () {
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
                              widget.item[0].toString(), // id sách
                              widget.item[7].toString(), // id user
                              detailCart,
                            );
                          }),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.06))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Danh sách sản phẩm',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 12),
                            builtList
                          ],
                        ),
                      ),
                    ),
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
                          widgetButton: WidgetButtonCardDetailOfProduct(
                            change: () {
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
                                widget.item[0].toString(), // id sách
                                widget.item[7].toString(), // id user
                                detailCart,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: rightWidth,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.06))),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Danh sách sản phẩm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 12),
                              builtList
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
