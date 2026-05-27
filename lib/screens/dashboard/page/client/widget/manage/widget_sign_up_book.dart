import 'dart:math';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/sign_up_book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_button_custom.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/book_modal.dart';
import 'package:exchange_book/model/type_book_modal.dart';
import 'package:exchange_book/model/user_modal.dart';

import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';
import 'card_book.dart';

class WidgetSignUpBook extends StatefulWidget {
  final UserModel user;
  final Function(BookModal bookModal) insert;

  const WidgetSignUpBook({super.key, required this.user, required this.insert});

  @override
  State<WidgetSignUpBook> createState() => _WidgetSignUpBookState();
}

class _WidgetSignUpBookState extends State<WidgetSignUpBook> {
  // Cubit instance
  final signUpBookCubit = SignUpBookCubit();

  // Controllers
  late TextEditingController datePurchaseController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();

    datePurchaseController = TextEditingController(
      text: signUpBookCubit.state.datePurchase,
    );
    priceController = TextEditingController(
      text: signUpBookCubit.state.price,
    );
    descriptionController = TextEditingController(
      text: signUpBookCubit.state.description,
    );
    quantityController = TextEditingController(
      text: signUpBookCubit.state.quantity,
    );
  }

  @override
  void dispose() {
    datePurchaseController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  Widget loadData(TypeBookModal typeBookModal) {
    return Column(
      children: [
        CardBook(
          width: min(MediaQuery.of(context).size.width, 400),
          link: typeBookModal.image,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetText(icon: Icons.menu_book_rounded, title: "Tên sách", content: typeBookModal.name_book),
              WidgetText(icon: Icons.category_rounded, title: "Loại", content: typeBookModal.type_book),
              WidgetText(icon: Icons.description_rounded, title: "Mô tả", content: "\n${typeBookModal.description}"),
              WidgetText(icon: Icons.sell_rounded, title: "Giá gốc", content: "\n${typeBookModal.price}"),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? cs.background : const Color(0xFFF7F8FC),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SignUpBookCubit, SignUpBookState>(
            bloc: signUpBookCubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            cs.primary.withOpacity(0.12),
                            cs.primary.withOpacity(0.04),
                            isDark ? cs.surface : Colors.white,
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                        border: Border.all(color: cs.primary.withOpacity(0.08)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: cs.primary.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(Icons.post_add_rounded, color: cs.primary, size: 26),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Đăng ký sách',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: -0.3)),
                              const SizedBox(height: 4),
                              Text('Thêm sách bạn muốn đổi/bán',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurface.withOpacity(0.6))),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form card
                    Container(
                      padding: const EdgeInsets.all(20),
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
                          // Image upload area
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cs.primary.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: cs.primary.withOpacity(0.08), style: BorderStyle.solid),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 96,
                                      height: 128,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: isDark ? cs.surface : Colors.white,
                                        border: Border.all(color: cs.onSurface.withOpacity(0.08)),
                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2))],
                                      ),
                                      child: signUpBookCubit.state.isLoading
                                          ? Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 32,
                                                    height: 32,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 3,
                                                      color: cs.primary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text('Đang xử lý...', style: TextStyle(fontSize: 10, color: cs.onSurface.withOpacity(0.5))),
                                                ],
                                              ),
                                            )
                                          : signUpBookCubit.state.path.isNotEmpty
                                              ? Center(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
                                                    child: Icon(Icons.check_circle_rounded, size: 40, color: Colors.green[600]),
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.image_outlined, size: 36, color: cs.onSurface.withOpacity(0.3)),
                                                    const SizedBox(height: 6),
                                                    Text('Ảnh bìa', style: TextStyle(fontSize: 11, color: cs.onSurface.withOpacity(0.4))),
                                                  ],
                                                ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Hình ảnh sách', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 15)),
                                          const SizedBox(height: 6),
                                          Text('Chọn ảnh bìa rõ ràng để người khác dễ nhận biết', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurface.withOpacity(0.55))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Buttons moved outside Row to avoid overflow
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 8,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: signUpBookCubit.state.isLoading
                                          ? null
                                          : () => signUpBookCubit.pickImage(ImageSource.gallery, () => toast("Hệ thống chưa có loại sách này")),
                                      icon: signUpBookCubit.state.isLoading
                                          ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white.withOpacity(0.7)))
                                          : const Icon(Icons.photo_library_rounded, size: 18),
                                      label: Text(signUpBookCubit.state.isLoading ? 'Đang tải...' : 'Chọn ảnh', style: const TextStyle(fontWeight: FontWeight.w600)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: cs.primary,
                                        foregroundColor: Colors.white,
                                        disabledBackgroundColor: cs.primary.withOpacity(0.5),
                                        disabledForegroundColor: Colors.white.withOpacity(0.7),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      ),
                                    ),
                                    if (signUpBookCubit.state.path.isNotEmpty && !signUpBookCubit.state.isLoading)
                                      OutlinedButton(
                                        onPressed: () => signUpBookCubit.reset(),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: cs.error,
                                          side: BorderSide(color: cs.error.withOpacity(0.4)),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        ),
                                        child: const Text('Xóa', style: TextStyle(fontWeight: FontWeight.w500)),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Section label
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Row(
                              children: [
                                Container(width: 4, height: 18, decoration: BoxDecoration(color: cs.primary, borderRadius: BorderRadius.circular(2))),
                                const SizedBox(width: 10),
                                Text('Thông tin sách', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: cs.onSurface.withOpacity(0.8))),
                              ],
                            ),
                          ),

                          WidgetTextFieldCustom(
                            controller: datePurchaseController,
                            textInputType: TextInputType.datetime,
                            hint: "DDMMYYYY",
                            iconData: Icons.edit_calendar,
                            onChange: (value) {
                              signUpBookCubit.changeDob(value);
                              if (value.length == 8) datePurchaseController.text = signUpBookCubit.state.datePurchase;
                            },
                          ),
                          const SizedBox(height: 14),
                          WidgetTextFieldCustom(
                            controller: priceController,
                            textInputType: TextInputType.number,
                            hint: "Giá",
                            iconData: Icons.price_change_sharp,
                            onChange: (value) => signUpBookCubit.changePrice(value),
                          ),
                          const SizedBox(height: 14),
                          WidgetTextFieldCustom(
                            controller: quantityController,
                            textInputType: TextInputType.number,
                            hint: "Số lượng",
                            iconData: Icons.confirmation_number_rounded,
                            onChange: (value) => signUpBookCubit.changeQuantity(value),
                          ),
                          const SizedBox(height: 14),
                          WidgetTextFieldArea(
                            controller: descriptionController,
                            textInputType: TextInputType.multiline,
                            hint: "Nhập mô tả",
                            iconData: Icons.format_indent_decrease,
                            onChange: (value) => signUpBookCubit.changeDescription(value),
                          ),

                          const SizedBox(height: 22),

                          // Loading indicator during upload
                          if (signUpBookCubit.state.isLoading)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: cs.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'Đang upload và nhận diện sách...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: cs.onSurface.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Vui lòng đợi trong giây lát',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: cs.onSurface.withOpacity(0.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // conditional preview + submit
                          if (signUpBookCubit.state.typeBookModal != null && !signUpBookCubit.state.isLoading) ...[
                            loadData(signUpBookCubit.state.typeBookModal!),
                            Align(
                              alignment: Alignment.centerRight,
                              child: WidgetButtonCustom(
                                handle: () {
                                  final typeBook = signUpBookCubit.state.typeBookModal!;
                                  final enteredPrice = double.tryParse(priceController.text) ?? 0;
                                  final basePrice = double.tryParse(typeBook.price) ?? 0;

                                  if (enteredPrice < basePrice * 0.5) {
                                    widget.insert(BookModal(
                                      date_purchase: datePurchaseController.text,
                                      price: priceController.text,
                                      description: descriptionController.text,
                                      status: "1",
                                      quantity: quantityController.text,
                                      image: signUpBookCubit.state.path,
                                      id_user: widget.user.id.toString(),
                                      id_type_book: typeBook.id.toString(),
                                    ));

                                    datePurchaseController.clear();
                                    priceController.clear();
                                    descriptionController.clear();
                                    quantityController.clear();
                                    signUpBookCubit.reset();
                                  } else {
                                    signUpBookCubit.changeError("Giá phải nhỏ hơn 50% giá gốc");
                                  }
                                },
                                text: "Thêm sản phẩm",
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],

                          if (signUpBookCubit.state.error.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: cs.error.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: cs.error.withOpacity(0.2)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline_rounded, size: 18, color: cs.error),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(signUpBookCubit.state.error, style: TextStyle(color: cs.error, fontWeight: FontWeight.w500, fontSize: 13))),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: const Icon( Icons.chevron_left  , size: 25,),
        onPressed: () {
          Navigator.pop(context) ;
        },
      ),
    );
  }
}
