import 'package:exchange_book/screens/dashboard/page/client/cubit/manage/page/list_item_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/list_cart/widget_item_manage.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WidgetListItemManage extends StatefulWidget {
  final List<dynamic> item ;
  final String textButton ;
  final Function (String idCart, int total) handleClick ;
  final int stateButton ;
  const WidgetListItemManage({super.key, required this.item, required this.textButton, required this.handleClick, required this.stateButton,});

  @override
  State<WidgetListItemManage> createState() => _WidgetListItemManageState();
}

class _WidgetListItemManageState extends State<WidgetListItemManage> {


  late ListItemCubit listItemCubit ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listItemCubit = ListItemCubit() ;
    listItemCubit.loadData(widget.item[0].toString(), widget.item[1]);

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListItemCubit , ListItemState>(
        bloc: listItemCubit,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue.shade400,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Tên: ${widget.item[4]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.maintext,
                        ),
                      ),
                    ),
                    const  SizedBox(height: 20),
                    for(int i = 0 ; i < listItemCubit.state.listItem.length ; i++)
                      WidgetItemManage(item: listItemCubit.state.listItem[i],) ,

                    const SizedBox(height: 10),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Trạng thái: ${listItemCubit.state.stateItem}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.maintext,
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Địa chỉ: ${widget.item[2]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.maintext,
                          ),
                        )
                    ),
                    const SizedBox(height: 20),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Tổng tiền: ${widget.item[3]} VND",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.maintext,
                          ),
                        )
                    ),
                    const SizedBox(height: 20),
                    if((widget.stateButton == 2 && widget.item[1] == "Đã xác nhận" && !listItemCubit.state.stateClick) || (widget.stateButton == 1 && widget.item[1] == "Đã chuyển" && !listItemCubit.state.stateClick))
                      GestureDetector(
                        onTap: () {
                          if(!listItemCubit.state.stateClick) {
                            widget.handleClick(widget.item[0].toString(), widget.item[3]) ;

                            if(widget.item[1] == "Đã xác nhận") {
                              listItemCubit.exchangeState("Đã chuyển");
                            }
                            else if (widget.item[1] == "Đã chuyển") {
                              listItemCubit.exchangeState("Đã nhận");
                            }
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:const  BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset:const  Offset(0, 1),
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
              const SizedBox(height: 20),
            ],
          );
        },
    );
  }
}
