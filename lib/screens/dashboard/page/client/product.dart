import 'dart:io';
import 'dart:math';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/main.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/product/product_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/best_item.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/detail/widget_button_card_detail_of_product.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/detail/widget_item_product.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/BookModal.dart';
import 'package:exchange_book/model/DetailCartModal.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/screens/dashboard/page/client/card_detail.dart';

import 'package:exchange_book/theme/theme.dart';

import '../../../../model/CartModal.dart';
import 'cart.dart';

class Product extends StatefulWidget {
  final UserModel userdata ;
  const Product({super.key, required this.userdata});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  // 0 -> list
  // 1 -> detail
  // 2 -> cart


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().loadData(widget.userdata.id.toString());
  }


  Widget getWidget(ProductState state) {
    if(state.page == "list") {
      return ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20 , right: 20 , bottom: 10),
            child: Text(
              "Danh sách sản phẩm",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.maintext,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 450,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for(int i = 0 ; i < min(state.listProductBest.length, 10) ; i++)
                  ProductItem(
                    item: state.listProductBest[i],
                    openItem: (item) {
                      context.read<ProductCubit>().openDetailProduct(item) ;
                    },
                    order: (bookModal, nameBook) {
                      DetailCartModal.saveDetail(
                        bookModal.id.toString(),
                        bookModal.id_user.toString(),
                        DetailCartModal(
                            bookModal: bookModal,
                            quantity: 1,
                            name_book: nameBook
                        ),

                      );
                    },
                  )

              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20 , right: 20 , bottom: 10),
                child: Text(
                  "Danh sách sản phẩm",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.maintext,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {context.read<ProductCubit>().pickImage(ImageSource.gallery, widget.userdata.id!);},
                child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child:Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Colors.blue,

                      ),
                      margin: const EdgeInsets.only(top: 0, left: 20 , right: 20 , bottom: 20),
                      child: const Center(
                        child: Text(
                          "Tìm kiếm sách bằng ảnh",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ),
                ),
              ),

            ],
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                for(int i = 0 ; i < state.listProduct.length ; i++)
                  BestItem(
                    item: state.listProduct[i],
                    openItem: (item) {context.read<ProductCubit>().openDetailProduct(item) ;},
                    order: (bookModal, nameBook) {
                      DetailCartModal.saveDetail(
                        bookModal.id.toString(),
                        bookModal.id_user.toString(),
                        DetailCartModal(
                            bookModal: bookModal,
                            quantity: 1,
                            name_book: nameBook
                        ),
                      );
                    },
                  )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
          )
        ],
      );
    }
    else if(state.page == "detail") {
      return SingleChildScrollView(
        child: CardDetail(
          item: state.detailProduct,
          widgetHasListButton: WidgetButtonCardDetailOfProduct(change: () {

          },),
          titleRight: 'Danh sách sản phẩm',
          list: LayoutBuilder(builder: (context, constraints) => Column(
            children: [
              for(int i = 0 ; i < state.listProduct.length ; i++)
                WidgetItemProduct(
                  width: constraints.maxWidth,
                  item: state.listProduct[i],
                  openItem: (item) {context.read<ProductCubit>().openDetailProduct(item) ;},
                )

            ],
          ),),

        ),
      ) ;
    }
    else {


      return Cart(handleInsert: (data, address, totalText, total, path) {

        CartModal.uploadCart(
          data,address,totalText,path,widget.userdata.id.toString(),
          () {
            toast("Thêm giỏ hàng thành công");
          },
          () {
            toast("Lỗi khi thêm giỏ hàng");
          },
        );

        widget.userdata.point = "${int.parse(widget.userdata.point) - total}";
        UserModel.saveUserData(widget.userdata);

        DetailCartModal.removeDetailCartData() ;
        context.read<ProductCubit>().back();

        },);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit , ProductState>(builder: (context, state) {
      if(state.isLoading){
        return const Center(child: CircularProgressIndicator());
      }
      else {
        return Scaffold(
            body: getWidget(state),
            floatingActionButton: FloatingActionButton(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(state.page == "list" ? Icons.shopping_cart : Icons.rotate_left , size: 25,),
              onPressed: () {context.read<ProductCubit>().handleFloatingButton();},
            )
        );
      }
    },);
  }
}
