import 'package:exchange_book/screens/dashboard/page/client/widget/manage/list_cart/widget_list_item_manage.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter/material.dart';

class WidgetListManage extends StatefulWidget {
  List<dynamic> list ;
  String textButton ;
  Function (String id_cart, int total) handleClick ;
  int trangthaibutton ;
  WidgetListManage({super.key, required this.list ,  required this.textButton, required this.handleClick, required this.trangthaibutton});

  @override
  State<WidgetListManage> createState() => _WidgetListManageState();
}

class _WidgetListManageState extends State<WidgetListManage> {


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: LayoutBuilder(builder: (context, constraints) => Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Danh sách sản phẩm",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),

            ),
            SizedBox(width: 20,) ,
            for(int i = 0 ; i < widget.list.length ; i++)
                WidgetListItemManage(
                  item: widget.list[i],
                  textButton: widget.textButton,
                  trangthaibutton: widget.trangthaibutton,
                  handleClick: (id_cart, total) {
                    widget.handleClick(id_cart, total) ;
                  },
                )

          ],
        ),

      ),),
    );
  }
}
