import 'package:flutter/material.dart';

class IntroduceProfileEdit extends StatefulWidget {
  final Function () handle ;
  const IntroduceProfileEdit({super.key , required this.handle});

  @override
  State<IntroduceProfileEdit> createState() => _IntroduceProfileEditState();
}

class _IntroduceProfileEditState extends State<IntroduceProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        child: GestureDetector(
          onTap: () {widget.handle() ;},
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 20,
                ),
                SizedBox(width:10,),
                Text(
                  "Chỉnh sửa",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
