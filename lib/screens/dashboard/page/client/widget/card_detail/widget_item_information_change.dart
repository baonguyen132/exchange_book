import 'package:exchange_book/screens/dashboard/page/client/cubit/card_detail/card_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/ConstraintData.dart';
import '../../../../widget/card/card_item_image.dart';


class WidgetItemInformationChange extends StatefulWidget {
  final List<dynamic> item ;
  final Widget widgetButton ;
  const WidgetItemInformationChange({
    super.key ,
    required this.item,
    required this.widgetButton
  });

  @override
  State<WidgetItemInformationChange> createState() => _WidgetItemInformationChangeState();

}

class _WidgetItemInformationChangeState extends State<WidgetItemInformationChange> {


  late CardDetailCubit cardDetailCubit ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardDetailCubit = CardDetailCubit();
    cardDetailCubit.loadData(widget.item[7].toString());
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDetailCubit , CardDetailState>(
      bloc: cardDetailCubit,
      builder: (context, state) => LayoutBuilder(
          builder: (context, constraints) => Wrap(
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
              const SizedBox(width: 20, height: 20,) ,
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
                      "- Mô tả: ${handleDecrease("\n${widget.item[5]}")}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.maintext
                      ),
                    ),

                    // 2 nút
                    const SizedBox(height: 20),

                    widget.widgetButton ,

                    const SizedBox(height: 20,) ,
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 15),
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(width: 1 , color: Colors.blue.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: cardDetailCubit.state.pathAva != "" ? BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(100)),
                                image:   DecorationImage(
                                  image: NetworkImage(
                                    "$location/${cardDetailCubit.state.pathAva}",
                                  ),
                                  fit: BoxFit.cover,
                                )
                            ): const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)) , color: Colors.blue),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardDetailCubit.state.user == null ? "Họ và tên" : cardDetailCubit.state.user!.name,
                                  style: const TextStyle(
                                    fontSize: 20 ,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  cardDetailCubit.state.user == null ? "Email" : cardDetailCubit.state.user!.email ,
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
          )
      ),
    );
  }

  String handleDecrease(String text) {
    return text.replaceAll('\n', '\n+');
  }
}
