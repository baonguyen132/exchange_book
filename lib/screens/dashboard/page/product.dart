import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/model/DetailCartModal.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/screens/dashboard/page/card_detail.dart';
import 'package:project_admin/screens/dashboard/page/cart.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/best_item.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/detail/widget_item_product.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/detail/widget_button_card_detail_of_product.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item_button.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../model/CartModal.dart';

class Product extends StatefulWidget {
  UserModel userdata ;
  Product({super.key, required this.userdata});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<dynamic>? list_product_best ;
  List<dynamic>? list_product ;
  int state = 0;
  late List<dynamic> data ;


  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;
  }

  void loadData() async {

    List<dynamic> data = await BookModal.exportBook(widget.userdata.id.toString()) ;
    setState(() {
      list_product_best = data ;
      list_product = data ;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null)  {
      _image = File(pickedFile.path);
      List<dynamic> data = (await BookModal.uploadImageScan(_image!,"/scan_books", widget.userdata.id!))! ;
      setState(() {
        list_product = data ;
      });
    }
  }

  Widget getWidget() {
    if(state == 0) {
      return ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20 , right: 20 , bottom: 10),
            child: Text(
              "Danh sách sản phẩm",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.maintext,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 450,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if(list_product_best != null)
                  for(int i = 0 ; i < min(list_product_best!.length, 10) ; i++)
                    ProductItem(
                      item: list_product_best![i],
                      openItem: (item) {
                        setState(() {
                          state = 1 ;
                          data = item ;
                        });
                      },
                      order: (bookModal, name_book) {
                        DetailCartModal.saveDetail(
                          bookModal.id.toString(),
                          bookModal.id_user.toString(),
                          DetailCartModal(
                            bookModal: bookModal,
                            quantity: 1,
                            name_book: name_book
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
                margin: EdgeInsets.only(top: 20, left: 20 , right: 20 , bottom: 10),
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
                onTap: () {
                  _pickImage(ImageSource.gallery) ;
                },
                child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue,

                      ),
                      margin: EdgeInsets.only(top: 0, left: 20 , right: 20 , bottom: 20),
                      child: Center(
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

          Container(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                if(list_product != null)
                  for(int i = 0 ; i < list_product!.length ; i++)
                    BestItem(
                      item: list_product![i],
                      openItem: (item) {
                        setState(() {
                          state = 1 ;
                          data = item ;
                        });
                      },
                      order: (bookModal, name_book) {
                        DetailCartModal.saveDetail(
                          bookModal.id.toString(),
                          bookModal.id_user.toString(),
                          DetailCartModal(
                              bookModal: bookModal,
                              quantity: 1,
                              name_book: name_book
                          ),
                        );
                      },
                    )

              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
          )
        ],
      );
    }
    else if(state == 1) {
      return SingleChildScrollView(
        child: CardDetail(
          item: data,
          wigetHasListButton: WidgetButtonCardDetailOfProduct(change: () {

          },),
          titleRight: 'Danh sách sản phẩm',
          list: LayoutBuilder(builder: (context, constraints) => Column(
            children: [
              if(list_product != null)
                for(int i = 0 ; i < list_product!.length ; i++)
                  WidgetItemProduct(
                    width: constraints.maxWidth,
                    item: list_product?[i],
                    openItem: (item) {
                      setState(() {
                        data = item ;
                        state = 0 ;
                      });
                    },
                  )
            ],
          ),),

        ),
      ) ;
    }
    else {
      return Cart(handleInsert: (data, address, totalText, total, path) {

        CartModal.uploadCart(
          data,address,totalText,path,widget.userdata.id.toString(),() {
          Fluttertoast.showToast(
            msg: "Thêm giỏ hàng thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );},
          () {
          Fluttertoast.showToast(
            msg: "Lỗi khi thêm giỏ hàng",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0,
          );},
        );

        widget.userdata.point = "${int.parse(widget.userdata.point) - total}";
        UserModel.saveUserData(widget.userdata);

        DetailCartModal.removeDetailCartData() ;
        setState(() {
          state = 0 ;
        });
            },);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Icon(state == 0 ? Icons.shopping_cart : Icons.rotate_left , size: 25,),
        onPressed: () {
          setState(() {
            if(state != 0 ) {
              state = 0 ;
            }
            else  {
              state = 2 ;
            }

          });
        },
      )
    );
  }
}
