import 'package:exchange_book/screens/dashboard/page/client/widget/manage/list_cart/widget_list_item_manage.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter/material.dart';

class WidgetListManage extends StatefulWidget {
  final List<dynamic> list ;
  final String textButton ;
  final Function (String idCart, int total) handleClick ;
  final int stateButton ;
  const WidgetListManage({super.key, required this.list ,  required this.textButton, required this.handleClick, required this.stateButton});

  @override
  State<WidgetListManage> createState() => _WidgetListManageState();
}

class _WidgetListManageState extends State<WidgetListManage> {


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Danh sách sản phẩm",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.maintext
              ),
            ),

          ),
          const SizedBox(width: 20,) ,
          for(int i = 0 ; i < widget.list.length ; i++)
              WidgetListItemManage(
                item: widget.list[i],
                textButton: widget.textButton,
                stateButton: widget.stateButton,
                handleClick: (idCart, total) {
                  widget.handleClick(idCart, total) ;
                },
              )

        ],
      ),),
    );
  }
}
