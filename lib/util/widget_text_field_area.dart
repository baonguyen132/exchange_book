import 'package:flutter/material.dart';

class WidgetTextFieldArea extends StatefulWidget {
  final TextEditingController controller ;
  final TextInputType textInputType ;
  final String hint ;
  final IconData iconData ;

  const WidgetTextFieldArea({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.hint,
    required this.iconData,
  });

  @override
  State<WidgetTextFieldArea> createState() => _WidgetTextFieldAreaState();
}

class _WidgetTextFieldAreaState extends State<WidgetTextFieldArea> {
  final FocusNode _focusNode = FocusNode() ;
  bool _isFocus = false ;

  @override
  void initState() {
    super.initState();
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
      minLines: 1,            // chiều cao tối thiểu (có thể điều chỉnh)
      maxLines: null,         // cho phép tự động giãn
      expands: false,

      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
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
    );
  }
}
