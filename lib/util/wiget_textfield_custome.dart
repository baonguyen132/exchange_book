import 'package:flutter/material.dart';

class WigetTextfieldCustome extends StatefulWidget {
  TextEditingController controller ;
  TextInputType textInputType ;
  String hint ;
  IconData iconData ;

  
  Function (String value)? onChange ;


  WigetTextfieldCustome({
    super.key, 
    required this.controller, 
    required this.textInputType, 
    required this.hint, 
    required this.iconData,
    this.onChange
  });

  @override
  State<WigetTextfieldCustome> createState() => _WigetTextfieldCustomeState();
}

class _WigetTextfieldCustomeState extends State<WigetTextfieldCustome> {
  final FocusNode _focusNode = FocusNode() ;
  bool _isFocus = false ;

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus ;
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode:  _focusNode,
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
          prefixIconColor: _isFocus ? Colors.blue : Colors.black,
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
      onChanged: (value) {
        widget.onChange!(value) ;
      },
    );
  }
}
