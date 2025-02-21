import 'package:flutter/material.dart';

class WidgetTextfieldPasswordCustome extends StatefulWidget {
  final FocusNode _focusNode = FocusNode() ;
  FocusNode? focusNodeNext ;
  TextEditingController controller ;
  String? hint ;
  bool _isVisibility = false ;
  bool _isFocus = false ;

  WidgetTextfieldPasswordCustome({super.key , this.focusNodeNext ,  this.hint = "Password", required this.controller});

  @override
  State<WidgetTextfieldPasswordCustome> createState() => _WidgetTextfieldPasswordCustomeState();
}

class _WidgetTextfieldPasswordCustomeState extends State<WidgetTextfieldPasswordCustome> {
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
      controller: widget.controller,
      focusNode: widget._focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !widget._isVisibility,
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
          prefixIcon: Icon(!widget._isVisibility ? Icons.lock : Icons.lock_open),
          prefixIconColor: widget._isFocus ? Colors.blue : Colors.black ,

          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget._isVisibility = !widget._isVisibility ;
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                widget._isVisibility ? Icons.visibility : Icons.visibility_off ,
                color: widget._isFocus ? Colors.blue : Colors.black ,
              ),
            ),
          )
      ),
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(widget.focusNodeNext) ;
      },
    );
  }
}
