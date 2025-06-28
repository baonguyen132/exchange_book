import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../model/TypeBookModal.dart';
import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';
import 'cardbook/card_type_book.dart';



class WidgetListProduct extends StatefulWidget {
  final Function (TypeBookModal typeBookModal) update ;
  final Function (TypeBookModal typeBookModal) delete ;

  final List<TypeBookModal> list ;
  const WidgetListProduct({
    super.key,
    required this.list,
    required this.update,
    required this.delete
  });

  @override
  State<WidgetListProduct> createState() => _WidgetListProductState();
}

class _WidgetListProductState extends State<WidgetListProduct> {
  void showEditProductDialog(
      BuildContext context,
      TypeBookModal typeBookModal,
      Function(TypeBookModal typeBookModal) onSubmit,
      ) {
    final TextEditingController nameBookController =
    TextEditingController(text: typeBookModal.name_book);
    final TextEditingController typeBookController =
    TextEditingController(text: typeBookModal.type_book);
    final TextEditingController descriptionController =
    TextEditingController(text: typeBookModal.description);
    final TextEditingController priceController = TextEditingController(text: typeBookModal.price);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        color: Theme.of(context).colorScheme.maintext, // Đổi màu tùy theo theme nếu cần
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
                  controller: nameBookController,
                  textInputType: TextInputType.text,
                  hint: "Nhập tên sách",
                  iconData: Icons.drive_file_rename_outline,
                ),
                const SizedBox(height: 16),
                WidgetTextFieldCustom(
                  controller: typeBookController,
                  textInputType: TextInputType.text,
                  hint: "Nhập loại sách",
                  iconData: Icons.book,
                ),
                const SizedBox(height: 16),
                WidgetTextFieldCustom(
                    controller: priceController,
                    textInputType: TextInputType.number,
                    hint: "Nhập giá sách",
                    iconData: Icons.price_change_outlined
                ),
                const SizedBox(height: 16,),
                WidgetTextFieldArea(
                  controller: descriptionController,
                  textInputType: TextInputType.multiline,
                  hint: "Nhập mô tả",
                  iconData: Icons.format_indent_decrease,
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
              label: const Text("Huỷ", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                onSubmit(
                  TypeBookModal(
                    id: typeBookModal.id,
                    name_book: nameBookController.text,
                    type_book: typeBookController.text,
                    description: descriptionController.text,
                    price: priceController.text,
                    image: typeBookModal.image,
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save , color: Colors.white,),
              label: const Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: List.generate(widget.list.length ,  (index) => CardTypeBook(
            typeBookModal: widget.list[index],
            edit: (typeBookModal) {
              showEditProductDialog(context, typeBookModal, (typeBookModal) {
                widget.update(typeBookModal) ;
              },);
            },
            delete: (typeBookModal) {
              widget.delete(typeBookModal);
            },
          ),),
        ),
      ),
    );
  }
}
