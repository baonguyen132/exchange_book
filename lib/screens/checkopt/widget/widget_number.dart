import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetNumber extends StatefulWidget {
  final TextEditingController textEditingController ;
  final FocusNode focusNode ;
  final FocusNode? focusNodeNext ;
  final bool isDesktop ;
  const WidgetNumber({super.key , required this.textEditingController , required this.focusNode , this.focusNodeNext , this.isDesktop = false});

  @override
  State<WidgetNumber> createState() => _WidgetNumberState();
}

class _WidgetNumberState extends State<WidgetNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.all(2),
      decoration: !widget.isDesktop ?
      BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade700,
            blurRadius: 60,
            spreadRadius: 10,
            offset: const Offset(0, 4)
          )
        ]
      ):
      BoxDecoration(
        color: Colors.blue.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigoAccent.withAlpha(150),
            offset: const Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 2
          )
        ]
      )
      ,
      child: TextFormField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1}$')), // Chỉ cho phép số và 1 chữ số
        ],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: widget.isDesktop ? Colors.white : Colors.black,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,


        ),
        onChanged: (value) {
          if(value.length == 1) {
            widget.focusNode.unfocus();
            FocusScope.of(context).requestFocus(widget.focusNodeNext) ;
          }
        },
      ),
    );
  }
}
