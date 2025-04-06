import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItemImage extends StatefulWidget {
  double width ;
  double height ;
  double borderRadius ;

  String link ;

  bool heart ;
  CardItemImage({super.key , required this.width , required this.height, required this.borderRadius , required this.heart , required this.link});

  @override
  State<CardItemImage> createState() => _CardItemImageState();
}

class _CardItemImageState extends State<CardItemImage> {
  bool clickheart = false ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        image: DecorationImage(
          image: NetworkImage(widget.link),
          fit: BoxFit.cover,
        )
      ),
      child: widget.heart ? Stack(
        children: [
          Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    clickheart =!clickheart ;
                  });
                },
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
                      color: clickheart ? Colors.red : Colors.black,
                      size: 30,
                      
                    ),
                  ),
                ),
              )
          )
        ],
      ):Container(),
    );
  }
}
