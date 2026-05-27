import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/type_book_modal.dart';
import 'package:exchange_book/util/widget_text_field_area.dart';

import '../../../../../../util/widget_text_field_custom.dart';

class WidgetFormInsertProduct extends StatefulWidget {
  final Function(TypeBookModal typeBookModal) insert;
  const WidgetFormInsertProduct({super.key, required this.insert});

  @override
  State<WidgetFormInsertProduct> createState() =>
      _WidgetFormInsertProductState();
}

class _WidgetFormInsertProductState extends State<WidgetFormInsertProduct> {
  final ImagePicker _picker = ImagePicker();
  String path = "";
  File? _image;

  IconData icon = Icons.close;
  Color color = Colors.red;

  TextEditingController nameBook = TextEditingController();
  TextEditingController typeBook = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController description = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      path = "";
      _image = File(pickedFile.path);
      Map<String, dynamic>? data = await TypeBookModal.ScanImage(_image!);
      String dataPath = await TypeBookModal.uploadImage(_image!);
      setState(() {
        path = dataPath ;
        nameBook.text = "${data?["name_book"]}";
        typeBook.text = "Sách lớp ${data?["class"]}";
        description.text = data?["description"];
        icon = Icons.check;
        color = Colors.green;
      });
    }
  }

  @override
  void dispose() {
    nameBook.dispose();
    typeBook.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;
    final surfaceColor = isDark ? const Color(0xFF252536) : const Color(0xFFF8F9FC);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
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
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.10),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add_box_rounded, color: theme.primaryColor, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thêm loại sách',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Upload ảnh và điền đầy đủ thông tin',
                            style: TextStyle(fontSize: 13, color: subtextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Upload area
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: surfaceColor,
                      border: Border.all(
                        color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.06),
                      ),
                    ),
                    child: Center(
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(_image!,
                                  fit: BoxFit.cover,
                                  width: 96,
                                  height: 128),
                            )
                          : path.isNotEmpty
                              ? Icon(Icons.check_circle,
                                  size: 48, color: Colors.green.shade400)
                              : Icon(Icons.image_outlined,
                                  size: 44,
                                  color: subtextColor),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hình ảnh bìa sách',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(
                            'Chọn ảnh bìa rõ ràng để hệ thống dễ nhận biết',
                            style: TextStyle(fontSize: 12, color: subtextColor)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library , color: Colors.white),
                              label: const Text('Chọn ảnh' , style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (path.isNotEmpty || _image != null)
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    path = '';
                                    _image = null;
                                    icon = Icons.close;
                                    color = Colors.red;
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Xóa'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Fields
            WidgetTextFieldCustom(
              controller: nameBook,
              textInputType: TextInputType.text,
              hint: "Nhập tên sách",
              iconData: Icons.drive_file_rename_outline,
            ),
            const SizedBox(height: 12),
            WidgetTextFieldCustom(
              controller: typeBook,
              textInputType: TextInputType.text,
              hint: "Nhập loại sách",
              iconData: Icons.book,
            ),
            const SizedBox(height: 12),
            WidgetTextFieldCustom(
              controller: price,
              textInputType: TextInputType.text,
              hint: "Nhập giá sách",
              iconData: Icons.price_change_outlined,
            ),
            const SizedBox(height: 12),
            WidgetTextFieldArea(
              controller: description,
              textInputType: TextInputType.multiline,
              hint: "Nhập mô tả",
              iconData: Icons.format_indent_decrease,
              onChange: (value) {},
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      nameBook.clear();
                      typeBook.clear();
                      price.clear();
                      description.clear();
                      setState(() {
                        path = '';
                        _image = null;
                        icon = Icons.close;
                        color = Colors.red;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: isDark ? Colors.white24 : Colors.black26),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('Huỷ', style: TextStyle(color: subtextColor)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
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
                    child: ElevatedButton(
                      onPressed: () {
                        widget.insert(TypeBookModal(
                            name_book: nameBook.text,
                            type_book: typeBook.text,
                            price: price.text,
                            description: description.text,
                            image: path));
                        nameBook.clear();
                        typeBook.clear();
                        price.clear();
                        description.clear();
                        setState(() {
                          path = '';
                          _image = null;
                          icon = Icons.close;
                          color = Colors.red;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Thêm sản phẩm' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
            // Extra space so FAB doesn't overlap
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
