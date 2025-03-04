import 'package:flutter/material.dart';
import 'package:project_admin/theme/theme.dart';

class IntroduceProfileItem extends StatefulWidget {
  int index ;
  IntroduceProfileItem({super.key , required this.index});

  @override
  State<IntroduceProfileItem> createState() => _IntroduceProfileItemState();
}

class _IntroduceProfileItemState extends State<IntroduceProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Container(
          padding: EdgeInsets.only(right: 30 , left: 30),
          child: Wrap(
            children: [
              Text(
                "- Item item item Item item item Item item item Item item item ${widget.index}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.maintext,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}
