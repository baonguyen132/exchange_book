import 'package:flutter/material.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/theme/theme.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../../../util/widget_textfield_area.dart';
import '../../../../../../util/wiget_textfield_custome.dart';
import '../../../../widget/card/card_item_image.dart';

class WidgetItemInformationChange extends StatefulWidget {
  List<dynamic> item ;
  Function (BookModal bookModal) editItem ;
  Function (BookModal bookModal) deleteItem ;
  WidgetItemInformationChange({
    super.key ,
    required this.item,
    required this.editItem,
    required this.deleteItem
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
    print(widget.item);
    loadData() ;

  }
  void loadData() async {

    UserModel? data = await UserModel.exportUser(widget.item[7].toString(),() {},) ;
    String? pathData = await UserModel.export_image_avata(widget.item[7].toString()) ;
    setState(() {
      user = data ;
      path = pathData!.replaceAll("\\", "/") ;

    });
  }

  void showEditProductDialog(
      BuildContext context,
      BookModal bookModal,
      Function(BookModal bookModal) onSubmit,
      ) {


    final TextEditingController date_purchaseController =
    TextEditingController(text: bookModal.date_purchase);
    final TextEditingController priceController =
    TextEditingController(text: bookModal.price);
    final TextEditingController descriptionController =
    TextEditingController(text: bookModal.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Wrap(
            alignment: WrapAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Chỉnh sửa thông tin", // Phần có màu mặc định
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.maintext, // Đổi màu tùy theo theme nếu cần
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WigetTextfieldCustome(
                  controller: date_purchaseController,
                  textInputType: TextInputType.datetime,
                  hint: "DDMMYYYY",
                  iconData: Icons.edit_calendar,
                  onChange: (value) {
                    if (value.length == 8) {
                      String formatted = formatIDToDate(value);
                      setState(() {
                        date_purchaseController.text = formatted;
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                WigetTextfieldCustome(controller: priceController, textInputType: TextInputType.number, hint: "giá", iconData: Icons.price_change_sharp),

                SizedBox(height: 16,),
                WidgetTextfieldArea(
                  controller: descriptionController,
                  textInputType: TextInputType.multiline,
                  hint: "Nhập mô tả",
                  iconData: Icons.format_indent_decrease,
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.cancel_outlined, color: Colors.grey),
              label: Text("Huỷ", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                onSubmit(
                  BookModal(
                    id: bookModal.id,
                    date_purchase: date_purchaseController.text,
                    status: bookModal.status,
                    description: descriptionController.text,
                    price: priceController.text,
                    image: bookModal.image,
                    id_user: bookModal.id_user,
                    id_type_book: bookModal.id_type_book
                  ),
                );
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save , color: Colors.white,),
              label: Text("Lưu", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
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
            width: constraints.maxWidth < 500 ? constraints.maxWidth : 300,
            height: constraints.maxWidth < 500 ? 500 : 400 ,
            borderRadius: 10,
            link: "$location/${widget.item[6]}", heart: false,
          ),
        ),
        SizedBox(width: 20, height: 20,) ,
        Container(
          width: constraints.maxWidth < 500 ? constraints.maxWidth : constraints.maxWidth - 350,
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
                "- Mô tả: ${handledesc("\n${widget.item[5]}")}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.maintext
                ),
              ),

              // 2 nút
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showEditProductDialog(context, BookModal(
                          id: widget.item[0].toString(),
                          date_purchase: widget.item[3],
                          price: widget.item[4].toString(),
                          description: widget.item[5],
                          status: widget.item[9].toString(),
                          image: widget.item[6],
                          id_user: widget.item[7].toString(),
                          id_type_book: widget.item[8].toString()
                      ), (bookModal) {
                        widget.editItem(bookModal);
                      },);
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(

                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Sửa",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.deleteItem(
                          BookModal(
                              id: widget.item[0].toString(),
                              date_purchase: widget.item[3],
                              price: widget.item[4].toString(),
                              description: widget.item[5],
                              status: widget.item[9].toString(),
                              image: widget.item[6],
                              id_user: widget.item[7].toString(),
                              id_type_book: widget.item[8].toString()
                          )
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(

                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.close,
                              color: Theme.of(context).colorScheme.maintext,
                              size: 20,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Xoá",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.maintext
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
