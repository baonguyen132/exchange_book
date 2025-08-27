import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/list_book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_button_custom.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:exchange_book/model/book_modal.dart';

import '../../../../../../model/cart_modal.dart';
import '../../../../../../model/user_modal.dart';
import 'card_book.dart';
import 'list_cart/widget_list_change.dart';

class WidgetListBook extends StatefulWidget {
  final UserModel user ;
  final Function (List<dynamic> data) handle ;

  const WidgetListBook({super.key, required this.user ,required this.handle});


  @override
  State<WidgetListBook> createState() => _WidgetListBookState();
}

class _WidgetListBookState extends State<WidgetListBook> {

  late ListBookCubit listBookCubit ;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBookCubit = ListBookCubit() ;
    listBookCubit.loadData(1,widget.user.id!);
  }


  Widget getListCart(int page , List<dynamic> list) {
    if(page == 1) {
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
            children: (list.isNotEmpty)
                ? list.map((e) =>
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
                            const SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Loại: ", content: e[2]),
                            const SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Ngày mua: ", content: e[3]),
                            const SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Còn lại: ", content: e[10].toString()),
                            const SizedBox(height: 15,),
                            WidgetText(icon: Icons.book, title: "Giá: ", content: e[4].toString()),

                          ],
                        ),
                      )),
                ),
            ).toList() : [],
          );
        },
      );
    }
    else if(page == 2) {
      return WidgetListManage(
        list: list,
        stateButton: 1,
        textButton: "Đã nhận",
        handleClick: (idCart, total) {
          CartModal.updateStateCart(widget.user.id!, idCart, "Đã nhận", total.toString(),
                () {toast("Cập nhật trạng thái thành công");},
                () {toast("Lỗi");},);
        },
      ) ;
    }
    else  {

      return WidgetListManage(
        list: list,
        stateButton: 2,
        textButton: "Đã chuyển",
        handleClick: (idCart, total) async {
          CartModal.updateStateCart(widget.user.id!, idCart, "Đã chuyển", total.toString(),
                () {toast("Cập nhật trạng thái thành công");},
                () { toast("Lỗi");},);
          UserModel? userModel = await UserModel.loadUserData() ;
          userModel?.point = "${int.parse(userModel.point) + total}";
          UserModel.saveUserData(userModel!);

        },
      ) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBookCubit , ListBookState>(
      bloc: listBookCubit,
      builder: (context, state) {
        return  Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: WidgetButtonCustom(
                      handle: () {listBookCubit.loadData(1, widget.user.id!);},
                      text: "Sách",
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: WidgetButtonCustom(
                      handle: () {listBookCubit.loadData(2, widget.user.id!);},
                      text: "Đơn đổi",
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: WidgetButtonCustom(
                      handle: () {listBookCubit.loadData(3, widget.user.id!);},
                      text: "Danh sách hàng",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),
            listBookCubit.state.isLoading ? const Center(child: CircularProgressIndicator()) : getListCart(listBookCubit.state.current , listBookCubit.state.list) ,
          ],
        );
      },);
  }
}
