import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

import 'introduce_profile_edit.dart';
import 'introduce_profile_item.dart';

class IntroduceProfile extends StatefulWidget {
  double? height ;
  double weight ;
  double margin ;
  IntroduceProfile({super.key , this.height , required this.weight , required this.margin});

  @override
  State<IntroduceProfile> createState() => _IntroduceProfileState();
}

class _IntroduceProfileState extends State<IntroduceProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.weight,
      height: widget.height,
      margin: EdgeInsets.all(widget.margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Theme.of(context).colorScheme.mainCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Màu bóng
            blurRadius: 10, // Độ mờ của bóng
            spreadRadius: 2, // Độ lan rộng của bóng
            offset: Offset(0, 4), // Vị trí bóng (x, y)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: const Text(
              "Profile",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
              child: Container(
                height: 0,
                child: ListView(
                  children: [
                    IntroduceProfileItem(
                      text: "Facebook",
                      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiXN9xSEe8unzPBEQOeAKXd9Q55efGHGB9BA&s",
                    ),
                    IntroduceProfileItem(
                      text: "Github",
                      imageUrl: "https://th.bing.com/th/id/OIP.nK06T8IQhsz5cs8NpOF-dwHaHa?rs=1&pid=ImgDetMain",
                    ),
                  ],
                ),
              )
          ),
          IntroduceProfileEdit(handle: () { 
            
          },)

        ],
      ),
    );
  }
}
