import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_button_custom.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exchange_book/model/BookModal.dart';

import '../../../../../../model/CartModal.dart';
import '../../../../../../model/UserModal.dart';
import 'card_book.dart';
import 'list_cart/widget_list_change.dart';

class WidgetListBook extends StatefulWidget {
  UserModel user ;
  Function (List<dynamic> data) handle ;

  WidgetListBook({super.key, required this.user ,required this.handle});


  @override
  State<WidgetListBook> createState() => _WidgetListBookState();
}

class _WidgetListBookState extends State<WidgetListBook> {

  List<dynamic>? list ;
  int state = 1 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData(state) ;
  }

  void loadData(int choose) async {
    List<dynamic> data ;
    if(choose == 1) {
      data = await BookModal.exporUserBook(widget.user.id.toString());
    }
    else if(choose == 2) {
      data = await CartModal.exportCartPurchase(widget.user.id.toString());
    }
    else {
      data = await CartModal.exportCartSeller(widget.user.id.toString());
    }
    setState(() {
      list = data ;
    });
  }



  Widget getListCart() {
    if(list == null ) return Container() ;
    if(state == 1) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double itemWidth = 370;
          double spacing = 20;

          // Tính xem tối đa hiển thị được mấy item trên 1 hàng
          int crossAxisCount = ((maxWidth + spacing) / (itemWidth + spacing)).floor();

          // Nếu không đủ để 1 hàng thì fallback còn 1
          crossAxisCount = crossAxisCount == 0 ? 1 : crossAxisCount;

          // Tính lại width cho đều
          double adjustedWidth = (maxWidth - ((crossAxisCount - 1) * spacing)) / crossAxisCount;

          return Wrap(
            spacing: spacing,
            runSpacing: 20,
            children: (list!.isNotEmpty)
                ? list!.map((e) =>
                GestureDetector(
                  onTap: () {widget.handle(e) ;},
                  child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CardBook(
                        width: adjustedWidth,
                        link: e[6],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e[1]),
                            SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Loại: ", content: e[2]),
                            SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Ngày mua: ", content: e[3]),
                            SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Còn lại: ", content: e[10].toString()),
                            SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Giá: ", content: e[4].toString()),

                          ],
                        ),
                      )),
                ),
            ).toList()
                : [],
          );
        },
      );
    }
    else if(state == 2) {
      return WidgetListManage(

        list: list!,
        trangthaibutton: 1,
        textButton: "Đã nhận",
        handleClick: (id_cart, total) {

          CartModal.updateStateCart(widget.user.id!, id_cart, "Đã nhận", total.toString(), () {
            Fluttertoast.showToast(
              msg: "Cập nhật trạng thái thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }, () {
            Fluttertoast.showToast(
              msg: "Lỗi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },);
        },
      ) ;
    }
    else  {

      return WidgetListManage(
        list: list!,
        trangthaibutton: 2,
        textButton: "Đã chuyển",
        handleClick: (id_cart, total) async {
          CartModal.updateStateCart(widget.user.id!, id_cart, "Đã chuyển", total.toString(), () {
            Fluttertoast.showToast(
              msg: "Cập nhật trạng thái thành công",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }, () {
            Fluttertoast.showToast(
              msg: "Lỗi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },);
          UserModel? userModel = await UserModel.loadUserData() ;
          userModel?.point = "${int.parse(userModel.point) + total}";
          UserModel.saveUserData(userModel!);

        },
      ) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: WidgetButtonCustom(
                  handle: () {setState(() {
                    state = 1 ;
                    list = null ;
                    loadData(state);
                  });},
                  text: "Sách",
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: WidgetButtonCustom(
                  handle: () {
                    setState(() { state = 2 ; list = null ; loadData(state);});
                  },
                  text: "Đơn đổi",
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: WidgetButtonCustom(
                  handle: () {
                    setState(() {state = 3; list = null ; loadData(state);});
                  },
                  text: "Danh sách hàng",
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20,),
        getListCart() ,

      ],
    );
  }
}
