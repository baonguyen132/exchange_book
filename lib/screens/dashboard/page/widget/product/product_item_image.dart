import 'package:flutter/material.dart';

class ProductItemImage extends StatefulWidget {
  double width ;
  double height ;
  BorderRadius borderRadius ;
  ProductItemImage({super.key , required this.width , required this.height , required this.borderRadius});

  @override
  State<ProductItemImage> createState() => _ProductItemImageState();
}

class _ProductItemImageState extends State<ProductItemImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        image: DecorationImage(
          image: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-hhlczgZCexRKviMmym1IW_Xngpb6ec3BWQ&s"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
