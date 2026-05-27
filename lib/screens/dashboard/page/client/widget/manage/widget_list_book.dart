import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/list_book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../../../model/book_modal.dart';
import '../../../../../../model/cart_modal.dart';
import '../../../../../../model/user_modal.dart';
import '../../../../widget/pagination.dart';
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
    listBookCubit.loadData(1, int.parse(widget.user.id!), 1);
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
                                  Text(e[1],
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: -0.2,
                                          )),
                                  const SizedBox(height: 8),
                                  WidgetText(
                                      icon: Icons.access_time_rounded,
                                      title: "Tuổi sách",
                                      content: "${tinhtuoisach(e[3])} năm"
                                  ),
                                  const SizedBox(height: 4),
                                  WidgetText(
                                      icon: Icons.inventory_2_rounded,
                                      title: "Còn lại",
                                      content: e[10].toString()),
                                  const SizedBox(height: 4),
                                  WidgetText(
                                      icon: Icons.sell_rounded,
                                      title: "Giá",
                                      content: e[4].toString()),
                                  const SizedBox(height: 6),

                                  WidgetButtonCardDetailOfHistory(
                                    item: e!,
                                    editItem: (bookModal) {BookModal.updateDatabaseBook(
                                      bookModal,
                                      "$location/updateBook",
                                      () {toast("Cập nhật thành công");listBookCubit.loadData(1, int.parse(widget.user.id!), 1);},
                                      () {toast("Cập nhật không thành công");listBookCubit.loadData(1, int.parse(widget.user.id!), 1);},
                                    );},
                                    deleteItem: (bookModal) {
                                      BookModal.updateDatabaseBook(
                                        bookModal, "$location/deleteBook",
                                        () {toast("Xoá thành công");listBookCubit.loadData(1, int.parse(widget.user.id!), 1);},
                                        () {toast("Không thể xoá được");listBookCubit.loadData(1, int.parse(widget.user.id!), 1);},
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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ListBookCubit, ListBookState>(
      bloc: listBookCubit,
      builder: (context, state) {
        return Column(
          children: [
            // Header
            LayoutBuilder(builder: (context, headerConstraints) {
              final options = ['Sách của tôi', 'Đơn đã mua', 'Đơn đã bán'];
              final currentIndex = (listBookCubit.state.current >= 1 &&
                      listBookCubit.state.current <= 3)
                  ? listBookCubit.state.current
                  : 1;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primary.withOpacity(0.10),
                      cs.primary.withOpacity(0.03),
                      isDark ? cs.surface : Colors.white,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                  border: Border.all(color: cs.primary.withOpacity(0.08)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.library_books_rounded, color: cs.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Text('Quản lý sách',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3))),
                  // Selector
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? cs.surface : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: cs.primary.withOpacity(0.12)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: currentIndex,
                        items: List.generate(options.length, (index) => DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(options[index], style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                        )),
                        onChanged: (i) {
                          if (i != null) { listBookCubit.loadData(i, int.parse(widget.user.id!), 1); }
                        },
                        icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: cs.primary),
                        isDense: true,
                        dropdownColor: isDark ? cs.surface : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ]),
              );
            }),

            const SizedBox(height: 8),

            // Loading or content
            listBookCubit.state.isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: CircularProgressIndicator(strokeWidth: 3, color: cs.primary),
                        ),
                        const SizedBox(height: 14),
                        Text('Đang tải...', style: TextStyle(color: cs.onSurface.withOpacity(0.5), fontSize: 13)),
                      ],
                    ),
                  )
                : getListCart(listBookCubit.state.current, listBookCubit.state.list),

            const SizedBox(height: 20),

            listBookCubit.state.list.isNotEmpty ||  listBookCubit.state.currentPage > 1 ? SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Pagination(
                      back: () {if(listBookCubit.state.currentPage != 1) {listBookCubit.change("-",listBookCubit.state.current , int.parse(widget.user.id!) );}},
                      next: () {if(listBookCubit.state.list.isNotEmpty){listBookCubit.change("+",listBookCubit.state.current,int.parse(widget.user.id!));}},
                      indexCurrent: listBookCubit.state.currentPage
                  ),],
                )
            ) : Container()
          ],
        );
      },
    );
  }
}
