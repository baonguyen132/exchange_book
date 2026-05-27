import 'package:exchange_book/screens/dashboard/page/manager/widget/book/card_type_book_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../model/type_book_modal.dart';
import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';
import '../../../../widget/pagination.dart';
import '../../cubit/book/book_cubit.dart';

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
        final isDark = theme.brightness == Brightness.dark;
        final cardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;
        final subtextColor = isDark ? Colors.white54 : Colors.black54;

        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.04),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor.withOpacity(0.15),
                                theme.primaryColor.withOpacity(0.05),
                              ],
                            ),
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
                                  style: TextStyle(fontSize: 13, color: subtextColor)),
                            ],
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Icon(Icons.close, color: subtextColor, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                          child: Text('Huỷ',
                              style: TextStyle(color: subtextColor)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                Color.lerp(theme.primaryColor, Colors.purple, 0.2)!,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                            icon: const Icon(Icons.save, color: Colors.white, size: 18),
                            label: const Text('Lưu',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;
    final searchFillColor = isDark ? const Color(0xFF252536) : const Color(0xFFF5F7FA);

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
            Column(
              children: [
                // Header card
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0xFF1E1E2C),
                              Color.lerp(const Color(0xFF1E1E2C), theme.primaryColor, 0.08)!,
                            ]
                          : [
                              Colors.white,
                              Color.lerp(Colors.white, theme.primaryColor, 0.06)!,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.10),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.library_books_rounded, color: theme.primaryColor, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Các loại sách',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Quản lý, thêm, sửa hoặc xóa loại sách',
                                    style: TextStyle(fontSize: 13, color: subtextColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
                                horizontal: 14, vertical: 12),
                            hintText: 'Tìm theo tên loại sách',
                            hintStyle: TextStyle(color: subtextColor, fontSize: 13),
                            prefixIcon:
                            Icon(Icons.search, size: 20, color: subtextColor),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, size: 20, color: subtextColor),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '' ;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: searchFillColor,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                const SizedBox(height: 14),
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
            const SizedBox(height: 20,),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Pagination(
                    back: () {if(context.read<BookCubit>().state.currentPage != 1) {context.read<BookCubit>().change("-");}},
                    next: () {if(widget.list.isNotEmpty){context.read<BookCubit>().change("+");}},
                    indexCurrent: context.read<BookCubit>().state.currentPage
                ),],
              )
            )
          ],
        )
      ),
    );
  }
}
