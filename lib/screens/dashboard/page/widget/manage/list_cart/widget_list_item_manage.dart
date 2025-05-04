import 'package:flutter/material.dart';
import 'package:project_admin/model/CartModal.dart';
import 'package:project_admin/screens/dashboard/page/widget/manage/list_cart/widget_item_manage.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../../model/BookModal.dart';
import '../widget_button_custom.dart';

class WidgetListItemManage extends StatefulWidget {
  List<dynamic> item ;
  String textButton ;
  Function (String id_cart, int total) handleClick ;
  int trangthaibutton ;
  WidgetListItemManage({super.key, required this.item, required this.textButton, required this.handleClick, required this.trangthaibutton});

  @override
  State<WidgetListItemManage> createState() => _WidgetListItemManageState();
}

class _WidgetListItemManageState extends State<WidgetListItemManage> {

  List<dynamic>? listItem ;
  bool click = false ;
  String trangthai = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void loadData() async {
    List<dynamic> data = await CartModal.exportItemCart(widget.item[0].toString());
    setState(() {
      trangthai = widget.item[1] ;
      listItem = data ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tên: ${widget.item[4]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.maintext,
                  ),
                ),
              ),
              SizedBox(height: 20),
              if(listItem != null)
                for(int i = 0 ; i < listItem!.length ; i++)
                  WidgetItemManage(item: listItem?[i],) ,

              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Trạng thái: $trangthai",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.maintext,
                    ),
                  )
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Địa chỉ: ${widget.item[2]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.maintext,
                    ),
                  )
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Tổng tiền: ${widget.item[3]} VND",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.maintext,
                    ),
                  )
              ),
              SizedBox(height: 20),
              if((widget.trangthaibutton == 2 && widget.item[1] == "Đã xác nhận" && !click) || (widget.trangthaibutton == 1 && widget.item[1] == "Đã chuyển" && !click))
                GestureDetector(
                  onTap: () {
                    if(!click) {
                      widget.handleClick(widget.item[0].toString(), widget.item[3]) ;
                      setState(() {
                        click = !click ;
                        if(widget.item[1] == "Đã xác nhận") {
                          trangthai = "Đã chuyển";
                        }
                        else if (widget.item[1] == "Đã chuyển") {
                          trangthai = "Đã nhận";
                        }
                      });
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ]
                      ),
                      height: 53,
                      alignment: Alignment.center,
                      child: Text(
                        widget.textButton,
                        textAlign: TextAlign.center,
                        style:  const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w100
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
