import 'dart:io';
import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/sign_up_book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_button_custom.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/book_modal.dart';
import 'package:exchange_book/model/type_book_modal.dart';
import 'package:exchange_book/model/user_modal.dart';

import '../../../../../../util/widget_text_field_area.dart';
import '../../../../../../util/widget_text_field_custom.dart';
import 'card_book.dart';



class WidgetSignUpBook extends StatefulWidget {
  final UserModel user ;
  final Function (BookModal bookModal) insert;

  const WidgetSignUpBook({super.key , required this.user , required this.insert});

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

    datePurchaseController = TextEditingController(text: signUpBookCubit.state.datePurchase,);
    priceController = TextEditingController(text: signUpBookCubit.state.price,);
    descriptionController = TextEditingController(text: signUpBookCubit.state.description,);
    quantityController = TextEditingController(text: signUpBookCubit.state.quantity,);
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
                WidgetText(icon: Icons.book, title: "Tên sách", content: typeBookModal.name_book),
                WidgetText(icon: Icons.book, title: "Loại: ", content: typeBookModal.type_book),
                WidgetText(icon: Icons.book, title: "Mô tả: ", content: "\n${typeBookModal.description}"),
                WidgetText(icon: Icons.book, title: "Giá gốc: ", content: "\n${typeBookModal.price}"),
              ],
            ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBookCubit , SignUpBookState>(
      bloc: signUpBookCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 2 , color: Colors.blue)
              ),
              child: Row(
                children: [
                  Container(
                    width: 200,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: GestureDetector(
                      onTap: () {signUpBookCubit.pickImage(ImageSource.gallery) ;},
                      child:const  MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Chọn ảnh",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: Center(child: Text("Upload hình ảnh sách"),))
                ],
              ),
            ),
            const SizedBox(height: 20,),
            WidgetTextFieldCustom(
              controller: datePurchaseController,
              textInputType: TextInputType.datetime,
              hint: "DDMMYYYY",
              iconData: Icons.edit_calendar,
              onChange: (value) {
                signUpBookCubit.changeDob(value);
                if (value.length == 8) datePurchaseController.text = signUpBookCubit.state.datePurchase ;
              },
            ),
            const SizedBox(height: 20,),
            WidgetTextFieldCustom(
                controller: priceController,
                textInputType: TextInputType.number,
                hint: "giá",
                iconData: Icons.price_change_sharp,
                onChange: (value) {signUpBookCubit.changePrice(value);},
              
            ),
            const SizedBox(height: 20,),
            WidgetTextFieldCustom(
                controller: quantityController,
                textInputType: TextInputType.number,
                hint: "Số lượng",
                iconData: Icons.confirmation_number_rounded,
                onChange: (value) {signUpBookCubit.changeQuantity(value);},
            ),
            const SizedBox(height: 20,),
            WidgetTextFieldArea(
                controller: descriptionController,
                textInputType: TextInputType.multiline,
                hint: "Nhập mô tả",
                iconData: Icons.format_indent_decrease,
                onChange: (value) => signUpBookCubit.changeDescription(value),
                
            ) ,
            const SizedBox(height: 20,),

            signUpBookCubit.state.typeBookModal != null ? Column(
              children: [
                loadData(signUpBookCubit.state.typeBookModal!),
                WidgetButtonCustom(
                    handle: ()  {
                      if(double.parse(priceController.text) < double.parse(signUpBookCubit.state.typeBookModal!.price) * 0.5) {
                        widget.insert(
                            BookModal(
                                date_purchase: datePurchaseController.text ,
                                price: priceController.text,
                                description: descriptionController.text,
                                status: "1",
                                quantity: quantityController.text,
                                image: signUpBookCubit.state.path,
                                id_user: widget.user.id.toString(),
                                id_type_book: signUpBookCubit.state.typeBookModal!.id.toString()
                            ));
                        datePurchaseController.clear();
                        priceController.clear();
                        descriptionController.clear();
                        quantityController.clear();

                        signUpBookCubit.reset();
                      }
                      else {signUpBookCubit.changeError("Giá phải nhỏ hơn 50% giá gốc");}
                    },
                    text: "Thêm sản phẩm"
                ),
              ],
            ) : Container(),


            const SizedBox(height: 20,),
            Text(
              signUpBookCubit.state.error,
              style: const TextStyle(color: Colors.red),
              maxLines: 2, // hoặc nhiều hơn tùy ý
              overflow: TextOverflow.ellipsis,
            )
          ],
        );
      },);
  }
}
