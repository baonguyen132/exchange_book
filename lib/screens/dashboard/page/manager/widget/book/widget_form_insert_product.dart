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
      List<String> data = (await TypeBookModal.uploadImageScan(_image!))!;
      setState(() {
        path = data[0];
        nameBook.text = "${data[1]} ${data[2]}";
        typeBook.text = "Sách lớp ${data[2]}";
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
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
                child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thêm loại sách',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Upload ảnh và điền đầy đủ thông tin',
                          style: TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    )
                ),
              );
            }),
            const SizedBox(height: 12,),
            // Main Card with upload area and fields
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Upload row
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Theme.of(context)
                            .dividerColor
                            .withOpacity(0.06)),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.background,
                          border: Border.all(
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.06)),
                        ),
                        child: Center(
                          child: _image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(_image!,
                                fit: BoxFit.cover,
                                width: 96,
                                height: 128),
                          )
                              : path.isNotEmpty
                              ? const Icon(Icons.check_circle,
                              size: 48, color: Colors.green)
                              : Icon(Icons.image_outlined,
                              size: 44,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hình ảnh bìa sách',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Text(
                                'Chọn ảnh bìa rõ ràng để hệ thống dễ nhận biết',
                                style:
                                Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () =>
                                      _pickImage(ImageSource.gallery),
                                  icon: const Icon(Icons.photo_library , color: Colors.white,),
                                  label: const Text('Chọn ảnh' , style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor),
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

                const SizedBox(height: 16),

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
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Huỷ',style: TextStyle(color: Colors.black54)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
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
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text('Thêm sản phẩm' , style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
