import 'package:flutter/material.dart';

class WidgetTextFieldPasswordCustom extends StatefulWidget {
  
  final TextEditingController controller ;
  final String? hint ;
  final Function (String value)  onChange ;

  final bool isVisibility ;
  final Function () changeVisibility ;

  const WidgetTextFieldPasswordCustom(
      {
        super.key,
        this.hint = "Password",
        required this.controller,
        required this.onChange,

        required this.isVisibility,
        required this.changeVisibility
      }
  );

  @override
  State<WidgetTextFieldPasswordCustom> createState() => _WidgetTextFieldPasswordCustomState();
}

class _WidgetTextFieldPasswordCustomState extends State<WidgetTextFieldPasswordCustom> {
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
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !widget.isVisibility,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
      ),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
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
          prefixIcon: Icon(!widget.isVisibility ? Icons.lock : Icons.lock_open),
          prefixIconColor: _isFocus ? Colors.blue : Colors.black ,

          suffixIcon: GestureDetector(
            onTap: () {widget.changeVisibility();},
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                !widget.isVisibility ? Icons.visibility : Icons.visibility_off ,
                color: _isFocus ? Colors.blue : Colors.black ,
              ),
            ),
          )
      ),
      onChanged: (value) => widget.onChange(value),
    );
  }
}
