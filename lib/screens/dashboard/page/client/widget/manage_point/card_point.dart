import 'package:barcode_widget/barcode_widget.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/ConstraintData.dart';

class CardPoint extends StatefulWidget {
  final UserModel userModel;
  final String pathAva ;
  const CardPoint({super.key, required this.userModel, required this.pathAva});

  @override
  State<CardPoint> createState() => _CardPointState();
}

class _CardPointState extends State<CardPoint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // bo góc đẹp hơn
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6), // đổ bóng xuống dưới
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                      image: NetworkImage("$location/${widget.pathAva}"),
                      fit: BoxFit.cover
                  ),

                ),
              ),
              const SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.maintext,
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    widget.userModel.cccd,
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.maintext,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
              const SizedBox(width: 30,),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 15,
                        color: Colors.white,

                      ),
                      const SizedBox(width: 10,),
                      Expanded(child: Text(
                        widget.userModel.point,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w200
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16), // khoảng cách với phần khác
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  // Bóng nổi mềm mại
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 8,
                    offset: const Offset(-4, -4),
                  ),
                ],
              ),
              child: BarcodeWidget(
                data: "${widget.userModel.id}-${widget.userModel.cccd}",
                barcode: Barcode.code128(),
                drawText: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
