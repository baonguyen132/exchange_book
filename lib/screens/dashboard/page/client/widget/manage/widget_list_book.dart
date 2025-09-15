import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/list_book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../../../model/book_modal.dart';
import '../../../../../../model/cart_modal.dart';
import '../../../../../../model/user_modal.dart';
import 'card_book.dart';
import 'widget_button_card_detail_of_history.dart';
import 'list_cart/widget_list_manage.dart';

class WidgetListBook extends StatefulWidget {
  final UserModel user;
  final Function(List<dynamic> data) handle;

  const WidgetListBook({super.key, required this.user, required this.handle});

  @override
  State<WidgetListBook> createState() => _WidgetListBookState();
}

class _WidgetListBookState extends State<WidgetListBook> {
  late ListBookCubit listBookCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listBookCubit = ListBookCubit();
    listBookCubit.loadData(1, widget.user.id!);
  }

  // small helper to show toast messages (used by cart update callbacks)
  void toast(String message) {
    try {
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT);
    } catch (e) {
      // fallback to snackbar if Fluttertoast failed or is unavailable
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  int tinhtuoisach(String tuoi)
  {
    DateTime ngayMua = DateTime.parse(tuoi);
    DateTime hienTai = DateTime.now();

    // Tính số năm tuổi sách
    int tuoiSach = hienTai.year - ngayMua.year;
    if (hienTai.month < ngayMua.month ||
        (hienTai.month == ngayMua.month && hienTai.day < ngayMua.day)) {
      tuoiSach--; // chưa tới ngày kỷ niệm => trừ đi 1
    }

    return tuoiSach ;
  }

  Widget getListCart(int page, List<dynamic> list) {
    if (page == 1) {
      return LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double itemWidth = 370;
          double spacing = 20;

          // Tính xem tối đa hiển thị được mấy item trên 1 hàng
          int crossAxisCount =
              ((maxWidth + spacing) / (itemWidth + spacing)).floor();

          // Nếu không đủ để 1 hàng thì fallback còn 1
          crossAxisCount = crossAxisCount == 0 ? 1 : crossAxisCount;

          // Tính lại width cho đều
          double adjustedWidth =
              (maxWidth - ((crossAxisCount - 1) * spacing)) / crossAxisCount;




          return Wrap(
            spacing: spacing,
            runSpacing: 20,
            children: (list.isNotEmpty)
                ? list
                    .map(
                      (e) => GestureDetector(
                        onTap: () {},
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  WidgetText(
                                      icon: Icons.book,
                                      title: "Tuổi sách: ",
                                      content: "${tinhtuoisach(e[3])} năm"
                                  ),
                                  const SizedBox(height: 5,),
                                  WidgetText(
                                      icon: Icons.book,
                                      title: "Còn lại: ",
                                      content: e[10].toString()),
                                  const SizedBox(height: 5,),
                                  WidgetText(
                                      icon: Icons.book,
                                      title: "Giá: ",
                                      content: e[4].toString()),
                                  const SizedBox(height: 5,),

                                  WidgetButtonCardDetailOfHistory(
                                    item: e!,
                                    editItem: (bookModal) {BookModal.updateDatabaseBook(
                                      bookModal,
                                      "$location/updateBook",
                                      () {toast("Cập nhật thành công");listBookCubit.loadData(1, widget.user.id!);},
                                      () {toast("Cập nhật không thành công");listBookCubit.loadData(1, widget.user.id!);},
                                    );},
                                    deleteItem: (bookModal) {
                                      BookModal.updateDatabaseBook(
                                        bookModal, "$location/deleteBook",
                                        () {toast("Xoá thành công");listBookCubit.loadData(1, widget.user.id!);},
                                        () {toast("Không thể xoá được");listBookCubit.loadData(1, widget.user.id!);},
                                      );
                                    },
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                    .toList()
                : [],
          );
        },
      );
    } else if (page == 2) {
      return WidgetListManage(
        list: list,
        stateButton: 1,
        textButton: "Đã nhận",
        handleClick: (idCart, total) {
          CartModal.updateStateCart(
            widget.user.id!,
            idCart,
            "Đã nhận",
            total.toString(),
            () {
              toast("Cập nhật trạng thái thành công");
            },
            () {
              toast("Lỗi");
            },
          );
        },
      );
    } else {
      return WidgetListManage(
        list: list,
        stateButton: 2,
        textButton: "Giao hàng",
        handleClick: (idCart, total) async {
          CartModal.updateStateCart(
            widget.user.id!,
            idCart,
            "Đang giao",
            total.toString(),
            () {
              toast("Cập nhật trạng thái thành công");
            },
            () {
              toast("Lỗi");
            },
          );
          UserModel? userModel = await UserModel.loadUserData();
          userModel?.point = "${int.parse(userModel.point) + total}";
          UserModel.saveUserData(userModel!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBookCubit, ListBookState>(
      bloc: listBookCubit,
      builder: (context, state) {
        return Column(
          children: [
            // Header: gradient (blue tint on left) with title on left and 4-option selector on the right
            LayoutBuilder(builder: (context, headerConstraints) {
              // Refined selector: grouped dropdown with nicer styling
              final options = ['Sách của tôi', 'Đơn đã mua', 'Đơn đã bán'];
              final currentIndex = (listBookCubit.state.current >= 1 &&
                      listBookCubit.state.current <= 3)
                  ? listBookCubit.state.current
                  : 1;

              Widget selector = ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 140, maxWidth: 220),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color:
                            Theme.of(context).dividerColor.withOpacity(0.06)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: currentIndex,
                        items: List.generate(
                          options.length,
                          (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text(options[index],
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        onChanged: (i) {
                          if (i != null) {
                            listBookCubit.loadData(i, widget.user.id!);
                          }
                        },
                        icon: Icon(Icons.keyboard_arrow_down,
                            size: 20,
                            color:
                                Theme.of(context).textTheme.bodySmall?.color),
                        isDense: true,
                        dropdownColor: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              );

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.08),
                      Colors.white
                    ],
                    stops: const [0.0, 0.9],
                  ),
                  border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.04)),
                ),
                child: Row(children: [
                  Container(
                      width: 6,
                      height: 36,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.14),
                          borderRadius: BorderRadius.circular(4))),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text('Quản lý sách',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700))),
                  selector,
                ]),
              );
            }),

            const SizedBox(
              height: 20,
            ),
            listBookCubit.state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : getListCart(
                    listBookCubit.state.current, listBookCubit.state.list),
          ],
        );
      },
    );
  }
}
