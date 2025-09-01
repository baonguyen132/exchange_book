import 'package:exchange_book/screens/dashboard/page/manager/cubit/book/book_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/manager/widget/book/widget_form_insert_product.dart';
import 'package:exchange_book/screens/dashboard/page/manager/widget/book/widget_list_product.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/type_book_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/ConstraintData.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BookCubit>().loadData();
  }

  Widget getFrame() {
    if (context.read<BookCubit>().state.frame) {
      final list = context.read<BookCubit>().state.list;
      return WidgetListProduct(
        list: list,
        update: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            "$location/updateTypeBook",
            () {
              context.read<BookCubit>().updateTypeBook(typeBookModal);
              toast("Cập nhật thành công");
            },
            () {
              toast("Cập nhật bị lỗi");
            },
          );
        },
        delete: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            "$location/deleteTypeBook",
            () {
              context.read<BookCubit>().deleteTypeBook(typeBookModal);
              toast("Xoá thành công");
            },
            () {
              toast("Không thể xoá được");
            },
          );
        },
      );
    } else {
      return WidgetFormInsertProduct(
        insert: (typeBookModal) {
          TypeBookModal.updateDatabaseTypeBook(
            typeBookModal,
            "$location/insertTypeBook",
            () {
              context.read<BookCubit>().addTypeBook(typeBookModal);
              toast("Thêm thành công");
            },
            () {
              toast("Thêm không thành công");
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          child: getFrame(),
        ),
        floatingActionButton: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<BookCubit>().changeScreen();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(state.frame ? Icons.add : Icons.arrow_back),
            );
          },
        ),
      );
    });
  }
}
