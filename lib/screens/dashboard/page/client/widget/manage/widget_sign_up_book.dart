import 'dart:math';

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
              WidgetText(
                  icon: Icons.book,
                  title: "Tên sách",
                  content: typeBookModal.name_book),
              WidgetText(
                  icon: Icons.book,
                  title: "Loại: ",
                  content: typeBookModal.type_book),
              WidgetText(
                  icon: Icons.book,
                  title: "Mô tả: ",
                  content: "\n${typeBookModal.description}"),
              WidgetText(
                  icon: Icons.book,
                  title: "Giá gốc: ",
                  content: "\n${typeBookModal.price}"),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBookCubit, SignUpBookState>(
      bloc: signUpBookCubit,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.12),
                      Colors.white,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.post_add,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Đăng ký sách',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text('Thêm sách bạn muốn đổi/bán',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Form card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image upload area with preview
                    Row(
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
                          child: signUpBookCubit.state.path.isNotEmpty
                              ? Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 48,
                                    color: Colors.green[600],
                                  ),
                                )
                              : Icon(Icons.image_outlined,
                                  size: 44,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hình ảnh sách',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text(
                                  'Chọn ảnh bìa rõ ràng để người khác dễ nhận biết',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () => signUpBookCubit
                                        .pickImage(ImageSource.gallery),
                                    icon: const Icon(Icons.photo_library),
                                    label: const Text('Chọn ảnh'),
                                  ),
                                  const SizedBox(width: 8),
                                  if (signUpBookCubit.state.path.isNotEmpty)
                                    OutlinedButton(
                                      onPressed: () => signUpBookCubit.reset(),
                                      child: const Text('Xóa'),
                                    ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Form fields
                    WidgetTextFieldCustom(
                      controller: datePurchaseController,
                      textInputType: TextInputType.datetime,
                      hint: "DDMMYYYY",
                      iconData: Icons.edit_calendar,
                      onChange: (value) {
                        signUpBookCubit.changeDob(value);
                        if (value.length == 8)
                          datePurchaseController.text =
                              signUpBookCubit.state.datePurchase;
                      },
                    ),
                    const SizedBox(height: 12),
                    WidgetTextFieldCustom(
                      controller: priceController,
                      textInputType: TextInputType.number,
                      hint: "Giá",
                      iconData: Icons.price_change_sharp,
                      onChange: (value) => signUpBookCubit.changePrice(value),
                    ),
                    const SizedBox(height: 12),
                    WidgetTextFieldCustom(
                      controller: quantityController,
                      textInputType: TextInputType.number,
                      hint: "Số lượng",
                      iconData: Icons.confirmation_number_rounded,
                      onChange: (value) =>
                          signUpBookCubit.changeQuantity(value),
                    ),
                    const SizedBox(height: 12),
                    WidgetTextFieldArea(
                      controller: descriptionController,
                      textInputType: TextInputType.multiline,
                      hint: "Nhập mô tả",
                      iconData: Icons.format_indent_decrease,
                      onChange: (value) =>
                          signUpBookCubit.changeDescription(value),
                    ),

                    const SizedBox(height: 18),

                    // conditional preview + submit
                    if (signUpBookCubit.state.typeBookModal != null) ...[
                      loadData(signUpBookCubit.state.typeBookModal!),
                      Align(
                        alignment: Alignment.centerRight,
                        child: WidgetButtonCustom(
                          handle: () {
                            if (double.parse(priceController.text) <
                                double.parse(signUpBookCubit
                                        .state.typeBookModal!.price) *
                                    0.5) {
                              widget.insert(BookModal(
                                date_purchase: datePurchaseController.text,
                                price: priceController.text,
                                description: descriptionController.text,
                                status: "1",
                                quantity: quantityController.text,
                                image: signUpBookCubit.state.path,
                                id_user: widget.user.id.toString(),
                                id_type_book: signUpBookCubit
                                    .state.typeBookModal!.id
                                    .toString(),
                              ));
                              datePurchaseController.clear();
                              priceController.clear();
                              descriptionController.clear();
                              quantityController.clear();
                              signUpBookCubit.reset();
                            } else {
                              signUpBookCubit
                                  .changeError("Giá phải nhỏ hơn 50% giá gốc");
                            }
                          },
                          text: "Thêm sản phẩm",
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    if (signUpBookCubit.state.error.isNotEmpty)
                      Text(signUpBookCubit.state.error,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
