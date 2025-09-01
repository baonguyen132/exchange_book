import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../../../model/book_modal.dart';
import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';

class WidgetButtonCardDetailOfHistory extends StatefulWidget {
  final List<dynamic> item;
  final Function(BookModal bookModal) editItem;
  final Function(BookModal bookModal) deleteItem;

  const WidgetButtonCardDetailOfHistory(
      {super.key,
      required this.item,
      required this.editItem,
      required this.deleteItem});

  @override
  State<WidgetButtonCardDetailOfHistory> createState() =>
      _WidgetButtonCardDetailOfHistoryState();
}

class _WidgetButtonCardDetailOfHistoryState
    extends State<WidgetButtonCardDetailOfHistory> {
  void showEditProductDialog(
    BuildContext context,
    BookModal bookModal,
    Function(BookModal bookModal) onSubmit,
  ) {
    final TextEditingController datePurchaseController =
        TextEditingController(text: bookModal.date_purchase);
    final TextEditingController priceController =
        TextEditingController(text: bookModal.price);
    final TextEditingController descriptionController =
        TextEditingController(text: bookModal.description);
    final TextEditingController quantityController =
        TextEditingController(text: bookModal.quantity);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Wrap(
            alignment: WrapAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Chỉnh sửa thông tin", // Phần có màu mặc định
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .maintext, // Đổi màu tùy theo theme nếu cần
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetTextFieldCustom(
                  controller: datePurchaseController,
                  textInputType: TextInputType.datetime,
                  hint: "DDMMYYYY",
                  iconData: Icons.edit_calendar,
                  onChange: (value) {
                    if (value.length == 8) {
                      String formatted = formatIDToDate(value);
                      setState(() {
                        datePurchaseController.text = formatted;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                WidgetTextFieldCustom(
                    controller: priceController,
                    textInputType: TextInputType.number,
                    hint: "Giá",
                    iconData: Icons.price_change_sharp),
                const SizedBox(height: 16),
                WidgetTextFieldCustom(
                    controller: quantityController,
                    textInputType: TextInputType.number,
                    hint: "Số lượng",
                    iconData: Icons.price_change_sharp),
                const SizedBox(
                  height: 16,
                ),
                WidgetTextFieldArea(
                  controller: descriptionController,
                  textInputType: TextInputType.multiline,
                  hint: "Nhập mô tả",
                  iconData: Icons.format_indent_decrease,
                  onChange: (value) {},
                ),
              ],
            ),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
              label: const Text("Huỷ", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                onSubmit(
                  BookModal(
                      id: bookModal.id,
                      date_purchase: datePurchaseController.text,
                      status: bookModal.status,
                      quantity: quantityController.text,
                      description: descriptionController.text,
                      price: priceController.text,
                      image: bookModal.image,
                      id_user: bookModal.id_user,
                      id_type_book: bookModal.id_type_book),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
              label: const Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Small primary edit button
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            height: 36,
            child: ElevatedButton.icon(
              onPressed: () {
                showEditProductDialog(
                  context,
                  BookModal(
                    id: widget.item[0].toString(),
                    date_purchase: widget.item[3],
                    price: widget.item[4].toString(),
                    description: widget.item[5],
                    status: widget.item[9].toString(),
                    quantity: widget.item[10].toString(),
                    image: widget.item[6],
                    id_user: widget.item[7].toString(),
                    id_type_book: widget.item[8].toString(),
                  ),
                  (bookModal) => widget.editItem(bookModal),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
                minimumSize: const Size(64, 36),
              ),
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Sửa', style: TextStyle(fontSize: 14)),
            ),
          ),
        ),

        // Small outlined delete button
        SizedBox(
          height: 36,
          child: OutlinedButton.icon(
            onPressed: () {
              widget.deleteItem(BookModal(
                id: widget.item[0].toString(),
                date_purchase: widget.item[3],
                price: widget.item[4].toString(),
                description: widget.item[5],
                status: widget.item[9].toString(),
                image: widget.item[6],
                quantity: widget.item[10].toString(),
                id_user: widget.item[7].toString(),
                id_type_book: widget.item[8].toString(),
              ));
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
              side: BorderSide(
                  color: Theme.of(context).colorScheme.error, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(64, 36),
            ),
            icon: Icon(Icons.delete_outline,
                size: 16, color: Theme.of(context).colorScheme.error),
            label: Text('Xoá',
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).colorScheme.error)),
          ),
        ),
      ],
    );
  }
}
