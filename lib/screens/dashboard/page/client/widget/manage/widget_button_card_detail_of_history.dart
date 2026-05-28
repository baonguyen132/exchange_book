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
        final cs = Theme.of(context).colorScheme;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [cs.primary.withOpacity(0.10), cs.primary.withOpacity(0.03)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit_note_rounded, color: cs.primary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chỉnh sửa thông tin",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: cs.maintext)),
                      const SizedBox(height: 2),
                      Text("Cập nhật thông tin sách",
                          style: TextStyle(fontSize: 13, color: cs.maintext.withOpacity(0.6))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetTextFieldCustom(controller: datePurchaseController, textInputType: TextInputType.datetime, hint: "DDMMYYYY", iconData: Icons.edit_calendar,
                  onChange: (value) {
                    if (value.length == 8) {
                      String formatted = formatIDToDate(value);
                      setState(() { datePurchaseController.text = formatted; });
                    }
                  },
                ),
                const SizedBox(height: 14),
                WidgetTextFieldCustom(controller: priceController, textInputType: TextInputType.number, hint: "Giá", iconData: Icons.price_change_sharp),
                const SizedBox(height: 14),
                WidgetTextFieldCustom(controller: quantityController, textInputType: TextInputType.number, hint: "Số lượng", iconData: Icons.confirmation_number_rounded),
                const SizedBox(height: 14),
                WidgetTextFieldArea(controller: descriptionController, textInputType: TextInputType.multiline, hint: "Nhập mô tả", iconData: Icons.format_indent_decrease, onChange: (value) {}),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text("Huỷ", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: cs.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
              onPressed: () {
                onSubmit(BookModal(id: bookModal.id, date_purchase: datePurchaseController.text, status: bookModal.status, quantity: quantityController.text, description: descriptionController.text, price: priceController.text, image: bookModal.image, id_user: bookModal.id_user, id_type_book: bookModal.id_type_book));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save_rounded, color: Colors.white, size: 18),
              label: const Text("Lưu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                showEditProductDialog(context, BookModal(id: widget.item[0].toString(), date_purchase: widget.item[3], price: widget.item[4].toString(), description: widget.item[5], status: widget.item[9].toString(), quantity: widget.item[10].toString(), image: widget.item[6], id_user: widget.item[7].toString(), id_type_book: widget.item[8].toString()), (bookModal) => widget.editItem(bookModal));
              },
              style: ElevatedButton.styleFrom(backgroundColor: cs.primary.withOpacity(0.10), foregroundColor: cs.primary, padding: const EdgeInsets.symmetric(horizontal: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0, minimumSize: const Size(64, 36)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: cs.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Icon(Icons.edit_rounded, size: 14, color: cs.primary)),
                const SizedBox(width: 8),
                Text('Sửa', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.primary)),
              ]),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                widget.deleteItem(BookModal(id: widget.item[0].toString(), date_purchase: widget.item[3], price: widget.item[4].toString(), description: widget.item[5], status: widget.item[9].toString(), image: widget.item[6], quantity: widget.item[10].toString(), id_user: widget.item[7].toString(), id_type_book: widget.item[8].toString()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: cs.error.withOpacity(0.08), foregroundColor: cs.error, padding: const EdgeInsets.symmetric(horizontal: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0, minimumSize: const Size(64, 36)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: cs.error.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Icon(Icons.delete_outline_rounded, size: 14, color: cs.error)),
                const SizedBox(width: 8),
                Text('Xoá', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.error)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
