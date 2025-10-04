import 'dart:math';

import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/add_point/add_point_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/addPoint/header.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/addPoint/pricing_info.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/addPoint/user_infor.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/vn_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../data/ConstraintData.dart';
import '../../../../model/transaction_modal.dart';
import '../../../../util/widget_text_field_custom.dart';

class AddPoint extends StatefulWidget {
  final UserModel userModel;
  const AddPoint({super.key, required this.userModel});

  @override
  State<AddPoint> createState() => _AddPointState();
}

class _AddPointState extends State<AddPoint> {
  late AddPointCubit addPointCubit;

  Future<void> makePayment(
      BuildContext context, String id, String amount) async {
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
      MaterialPageRoute(builder: (_) => VnPayScreen(paymentUrl: payUrl)),
    );

    if (result == '00') {
      TransactionModel.updateHistoryTransaction(
        point: amount,
        price: amount,
        state: true,
        id_user: widget.userModel.id.toString(),
        successful: () async {

          int? currentPoint = await UserModel.loadPointData() ;
          currentPoint = currentPoint! + int.parse(amount);
          UserModel.savePointData(currentPoint);

          toast("Nạp tiền thành công");
        },
        fail: () {
          toast("Nạp tiền thành công");
        },
      );
      print("Payment success");
    } else {
      print("Payment failed or cancelled");
    }
    Navigator.pop(context);
  }


  late TextEditingController pointController;

  @override
  void initState() {
    super.initState();
    addPointCubit = AddPointCubit(widget.userModel);
    addPointCubit.loading();
    pointController =
        TextEditingController(text: addPointCubit.state.amout.toString());
  }

  Widget _buildFormSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nạp tiền",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetTextFieldCustom(
                controller: pointController,
                textInputType: TextInputType.number,
                hint: "Số tiền cần nạp",
                iconData: Icons.stars_outlined,
                onChange: (value) => addPointCubit.exchangePoint(int.parse(value)),
              ),
              if (addPointCubit.state.errorAmout.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red.shade200,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red.shade600,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          addPointCubit.state.errorAmout,
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          // Purchase Button
          GestureDetector(
            onTap: () {
              if (addPointCubit.state.errorAmout.isEmpty && addPointCubit.state.amout > 0) {
                makePayment(
                  context,
                  addPointCubit.state.idPurchasePoint,
                  addPointCubit.state.amout.toString(),
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: addPointCubit.state.errorAmout.isEmpty && addPointCubit.state.amout > 0
                      ? [
                          Colors.blue.shade600,
                          Colors.blue.shade700,
                        ]
                      : [
                          Colors.grey.shade400,
                          Colors.grey.shade500,
                        ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: addPointCubit.state.errorAmout.isEmpty && addPointCubit.state.amout > 0
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Nạp tiền",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<AddPointCubit, AddPointState>(
        bloc: addPointCubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Header(),
                UserInfor(userModel: widget.userModel),
                _buildFormSection(),
                const PricingInfo(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
