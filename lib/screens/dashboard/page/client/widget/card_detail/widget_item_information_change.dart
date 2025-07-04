import 'package:flutter/material.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/theme/theme.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../widget/card/card_item_image.dart';


class WidgetItemInformationChange extends StatefulWidget {
  List<dynamic> item ;
  Widget widgetButton ;
  WidgetItemInformationChange({
    super.key ,
    required this.item,
    required this.widgetButton
  });

  @override
  State<WidgetItemInformationChange> createState() => _WidgetItemInformationChangeState();

}

class _WidgetItemInformationChangeState extends State<WidgetItemInformationChange> {

  UserModel? user ;
  String path = "" ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.item[0]);
    loadData() ;

  }
  void loadData() async {
    UserModel? data = await UserModel.exportUser(widget.item[7].toString(),() {},) ;
    String? pathData = await UserModel.export_image_avata(widget.item[7].toString()) ;
    setState(() {
      user = data ;
      if(pathData != null){
        path = pathData.replaceAll("\\", "/") ;
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 5, color: Colors.blue),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: CardItemImage(
            width: constraints.maxWidth < 500 ? constraints.maxWidth : 350,
            height: constraints.maxWidth < 500 ? 500 : 450 ,
            borderRadius: 10,
            link: "$location/${widget.item[6]}", heart: false,
          ),
        ),
        SizedBox(width: 20, height: 20,) ,
        Container(
          width: constraints.maxWidth < 500 ? constraints.maxWidth : constraints.maxWidth - 400,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item[1],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "- Loại: ${widget.item[2]}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "- Ngày mua: ${widget.item[3]}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "- Giá: ${widget.item[4]} VNĐ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "- Còn lại: ${widget.item[10]}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "- Mô tả: ${handledesc("\n${widget.item[5]}")}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),

              // 2 nút
              SizedBox(height: 20),

              widget.widgetButton ,

              SizedBox(height: 20,) ,
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 15),
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(width: 1 , color: Colors.blue.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: path != "" ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          image:   DecorationImage(
                            image: NetworkImage(
                              "$location/$path",
                            ),
                            fit: BoxFit.cover,
                          )
                      ): const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)) , color: Colors.blue),
                    ),
                    SizedBox(width: 10,),
                    Expanded(child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user == null ? "Họ và tên" : user!.name,
                            style: const TextStyle(
                              fontSize: 20 ,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            user == null ? "Email" : user!.email ,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.maintext
                            ),
                          ),


                        ],
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),

      ],
    ),);
  }

  String handledesc(String text) {
    return text.replaceAll('\n', '\n+');
  }
}
