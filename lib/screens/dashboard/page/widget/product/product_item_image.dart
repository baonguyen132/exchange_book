import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItemImage extends StatefulWidget {
  double width ;
  double height ;
  ProductItemImage({super.key , required this.width , required this.height});

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
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        image: DecorationImage(
          image: NetworkImage("https://nld.mediacdn.vn/2020/9/7/anh-1-15994611977581569666831.gif"),
          fit: BoxFit.cover,
        )
      ),
      child: Stack(
        children: [
          Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white
                    ),
                    child: Icon(
                      CupertinoIcons.heart_fill,
                      size: 30,
                      
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
