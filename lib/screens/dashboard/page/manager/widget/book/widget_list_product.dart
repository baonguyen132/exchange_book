import 'package:exchange_book/screens/dashboard/page/manager/widget/book/card_type_book_mobile.dart';
import 'package:flutter/material.dart';

import '../../../../../../model/type_book_modal.dart';
import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';

class WidgetListProduct extends StatefulWidget {
  final Function(TypeBookModal typeBookModal) update;
  final Function(TypeBookModal typeBookModal) delete;

  final List<TypeBookModal> list;
  const WidgetListProduct(
      {super.key,
      required this.list,
      required this.update,
      required this.delete});

  @override
  State<WidgetListProduct> createState() => _WidgetListProductState();
}

class _WidgetListProductState extends State<WidgetListProduct> {

  final TextEditingController _searchController = TextEditingController();
  String _query = '' ;


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    final TextEditingController priceController =
        TextEditingController(text: typeBookModal.price);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 6))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.edit, color: theme.primaryColor),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chỉnh sửa thông tin',
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('Cập nhật thông tin loại sách',
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.black54)),
                            ],
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    LayoutBuilder(builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 600;
                      return SingleChildScrollView(
                        child: isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        WidgetTextFieldCustom(
                                          controller: nameBookController,
                                          textInputType: TextInputType.text,
                                          hint: "Nhập tên sách",
                                          iconData:
                                              Icons.drive_file_rename_outline,
                                        ),
                                        const SizedBox(height: 12),
                                        WidgetTextFieldCustom(
                                          controller: priceController,
                                          textInputType: TextInputType.number,
                                          hint: "Nhập giá sách",
                                          iconData: Icons.price_change_outlined,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        WidgetTextFieldCustom(
                                          controller: typeBookController,
                                          textInputType: TextInputType.text,
                                          hint: "Nhập loại sách",
                                          iconData: Icons.book,
                                        ),
                                        const SizedBox(height: 12),
                                        WidgetTextFieldArea(
                                          controller: descriptionController,
                                          textInputType:
                                              TextInputType.multiline,
                                          hint: "Nhập mô tả",
                                          iconData:
                                              Icons.format_indent_decrease,
                                          onChange: (value) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  WidgetTextFieldCustom(
                                    controller: nameBookController,
                                    textInputType: TextInputType.text,
                                    hint: "Nhập tên sách",
                                    iconData: Icons.drive_file_rename_outline,
                                  ),
                                  const SizedBox(height: 12),
                                  WidgetTextFieldCustom(
                                    controller: typeBookController,
                                    textInputType: TextInputType.text,
                                    hint: "Nhập loại sách",
                                    iconData: Icons.book,
                                  ),
                                  const SizedBox(height: 12),
                                  WidgetTextFieldCustom(
                                    controller: priceController,
                                    textInputType: TextInputType.number,
                                    hint: "Nhập giá sách",
                                    iconData: Icons.price_change_outlined,
                                  ),
                                  const SizedBox(height: 12),
                                  WidgetTextFieldArea(
                                    controller: descriptionController,
                                    textInputType: TextInputType.multiline,
                                    hint: "Nhập mô tả",
                                    iconData: Icons.format_indent_decrease,
                                    onChange: (value) {},
                                  ),
                                ],
                              ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Huỷ',
                              style: TextStyle(color: Colors.black54)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
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
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text('Lưu',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final filtered = _query.isEmpty
        ? widget.list
        : widget.list
            .where((e) => e.name_book.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: SingleChildScrollView(

        child: Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.95, 0.95), // subtle bottom-right
                    radius: 1.0,
                    colors: [
                      Colors.white,
                      Colors.blue.withOpacity(0.5),
                    ],
                    stops: const [0.9, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Các loại sách',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Quản lý, thêm, sửa hoặc xóa loại sách',
                          style: TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _query = value ;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            hintText: 'Tìm theo tên loại sách',
                            prefixIcon:
                            const Icon(Icons.search, size: 20),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '' ;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                          ),
                        ),
                      ],
                    )
                ),
              );
            }),
            const SizedBox(height: 12,),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: List.generate(
                filtered.length,
                (index) => CardTypeBookMobile(
                  typeBookModal: filtered[index],
                  edit: (typeBookModal) {
                    showEditProductDialog(
                      context,
                      typeBookModal,
                      (typeBookModal) {
                        widget.update(typeBookModal);
                      },
                    );
                  },
                  delete: (typeBookModal) {
                    widget.delete(typeBookModal);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
