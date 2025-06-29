import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemButton extends StatefulWidget {
  final Function () handle  ;

  const ProductItemButton({super.key , required this.handle});

  @override
  State<ProductItemButton> createState() => _ProductItemButtonState();
}

class _ProductItemButtonState extends State<ProductItemButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,

      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(100))
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {widget.handle() ;},
        child: const MouseRegion(
          child: Icon(
            CupertinoIcons.cart_fill_badge_plus,
            color: Colors.white,

          ),
        ),
      ),
    );
  }
}
