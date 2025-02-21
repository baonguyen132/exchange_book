import 'package:flutter/material.dart';

class WigetTextfieldCustome extends StatefulWidget {
  final FocusNode _focusNode = FocusNode() ;
  FocusNode? focusNodeNext ;
  TextEditingController controller ;
  TextInputType textInputType ;
  String hint ;
  IconData iconData ;
  bool _isFocus = false ;


  WigetTextfieldCustome({super.key, this.focusNodeNext , required this.controller, required this.textInputType, required this.hint, required this.iconData,});

  @override
  State<WigetTextfieldCustome> createState() => _WigetTextfieldCustomeState();
}

class _WigetTextfieldCustomeState extends State<WigetTextfieldCustome> {
  @override
  void initState() {
    // TODO: implement initState
    widget._focusNode.addListener(() {
      setState(() {
        widget._isFocus = widget._focusNode.hasFocus ;
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode:  widget._focusNode,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: widget.hint,
          hintStyle: const TextStyle(
            letterSpacing: 1,
          ),
          prefixIcon: Icon(widget.iconData),
          prefixIconColor: widget._isFocus ? Colors.blue : Colors.black,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2
              )
          )
      ),
      onFieldSubmitted: (value) {

        FocusScope.of(context).requestFocus(widget.focusNodeNext);
      },
    );
  }
}
