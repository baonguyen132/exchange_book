import 'package:flutter/material.dart';

class WidgetTextfieldPasswordCustome extends StatefulWidget {
  
  TextEditingController controller ;
  String? hint ;

  WidgetTextfieldPasswordCustome({super.key,  this.hint = "Password", required this.controller});

  @override
  State<WidgetTextfieldPasswordCustome> createState() => _WidgetTextfieldPasswordCustomeState();
}

class _WidgetTextfieldPasswordCustomeState extends State<WidgetTextfieldPasswordCustome> {
  final FocusNode _focusNode = FocusNode() ;
  bool _isVisibility = false ;
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
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_isVisibility,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: widget.hint,
          hintStyle: const TextStyle(letterSpacing: 1),
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2
              )
          ),
          prefixIcon: Icon(!_isVisibility ? Icons.lock : Icons.lock_open),
          prefixIconColor: _isFocus ? Colors.blue : Colors.black ,

          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isVisibility = !_isVisibility ;
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                _isVisibility ? Icons.visibility : Icons.visibility_off ,
                color: _isFocus ? Colors.blue : Colors.black ,
              ),
            ),
          )
      ),
    );
  }
}
