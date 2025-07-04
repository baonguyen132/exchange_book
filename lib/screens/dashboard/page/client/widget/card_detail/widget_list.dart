import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';

class WidgetList extends StatefulWidget {
  String title ;
  Widget  list ;
  WidgetList({super.key , required this.title , required this.list});

  @override
  State<WidgetList> createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.maintext,
          ),
        ),
        const SizedBox(height: 20,),
        widget.list
      ],
    );
  }
}
