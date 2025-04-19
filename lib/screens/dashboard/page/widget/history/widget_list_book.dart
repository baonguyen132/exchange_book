import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/card_book.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_text.dart';

import '../../../../../model/UserModal.dart';

class WidgetListBook extends StatefulWidget {
  List<dynamic> list ;
  Function (int choose) handleChoose ;
  Function (List<dynamic> data) handle ;

  WidgetListBook({super.key, required this.list , required this.handle , required this.handleChoose});


  @override
  State<WidgetListBook> createState() => _WidgetListBookState();
}

class _WidgetListBookState extends State<WidgetListBook> {

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
                  handle: () {widget.handleChoose(1);},
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
                    setState(() {widget.handleChoose(2);});
                  },
                  text: "Sách đổi",
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20,),
        LayoutBuilder(
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
              children: (widget.list.isNotEmpty)
                  ? widget.list.map((e) =>
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
                            SizedBox(height: 20,),
                            WidgetText(icon: Icons.book, title: "Loại: ", content: e[2]),
                            SizedBox(height: 20,),
                            WidgetText(icon: Icons.book, title: "Ngày mua: ", content: e[3]),
                            SizedBox(height: 20,),
                            WidgetText(icon: Icons.book, title: "Giá: ", content: e[4].toString()),

                          ],
                        ),
                      )),
                    ),
                  ).toList()
                  : [],
            );
          },
        )

      ],
    );
  }
}
