import 'dart:math';

import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/add_point/add_point_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/card_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/vn_pay.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../data/ConstraintData.dart';
import '../../../../model/transaction_modal.dart';
import '../../../../util/widget_text_field_custom.dart';

class AddPoint extends StatefulWidget {
  final UserModel userModel ;
  const AddPoint({super.key, required this.userModel});

  @override
  State<AddPoint> createState() => _AddPointState();
}

class _AddPointState extends State<AddPoint> {

  late AddPointCubit addPointCubit  ;

  Future<void> makePayment(BuildContext context , String id , String amount) async {
    final response = await http.post(
      Uri.parse("$location/create_payment_url"),
      body: {
        'orderId': id,
        'amount': amount,
      },
    );

    final payUrl = response.body;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VnPayScreen(paymentUrl: payUrl),),
    );

    if (result == '00') {
      TransactionModel.updateHistoryTransaction(
          point: amount,
          price:  amount,
          state: true,
          id_user: widget.userModel.id.toString(),
          successful: () {toast("Thêm điểm thành công");},
          fail: () {toast("Thêm điểm thành công");},
      );
      print("Payment success");
    } else {
      print("Payment failed or cancelled");
    }
    Navigator.pop(context);
  }


  late TextEditingController idController ;
  late TextEditingController pointController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPointCubit = AddPointCubit(widget.userModel);
    addPointCubit.loading() ;
    pointController = TextEditingController(text: addPointCubit.state.amout.toString());
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: BlocBuilder<AddPointCubit, AddPointState>(
        bloc: addPointCubit,
        builder: (context, state) {
          idController = TextEditingController(text: addPointCubit.state.idPurchasePoint);
          return Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
                width: min(500, MediaQuery.of(context).size.width),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 320,
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              color: Colors.blue,
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: GestureDetector(
                                  onTap: () {Navigator.pop(context);},
                                  child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.arrow_left_circle,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Quay lai",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mua điểm",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Theme.of(context).colorScheme.maintext,


                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                WidgetTextFieldCustom(
                                  controller: idController,
                                  textInputType: TextInputType.name,
                                  hint: "ID",
                                  iconData: Icons.perm_identity,
                                  onChange: (value) =>  addPointCubit.exChangeID(value),

                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    WidgetTextFieldCustom(
                                      controller: pointController,
                                      textInputType: TextInputType.emailAddress,
                                      hint: "Point",
                                      iconData: Icons.monetization_on_outlined,
                                      onChange: (value) => addPointCubit.exchangePoint(int.parse(value)),
                                    ),
                                    if(addPointCubit.state.errorAmout != "")
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Text(addPointCubit.state.errorAmout , style: const TextStyle(color: Colors.red),)
                                        ],
                                      )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    if(addPointCubit.state.errorAmout == ""){
                                      makePayment(
                                          context,
                                          addPointCubit.state.idPurchasePoint,
                                          addPointCubit.state.amout.toString()
                                      );
                                    }

                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: const Text(
                                        "Mua điểm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),

                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                )
            ),
          );
        }
      )
    );
  }
}
