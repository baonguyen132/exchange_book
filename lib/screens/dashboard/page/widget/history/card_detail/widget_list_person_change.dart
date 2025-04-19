import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/card_detail/widget_item_person_change.dart';
import 'package:project_admin/theme/theme.dart';

class WidgetListPersonChange extends StatefulWidget {
  Function () change ;
  Function () nochange ;
  WidgetListPersonChange({super.key , required this.change , required this.nochange});

  @override
  State<WidgetListPersonChange> createState() => _WidgetListPersonChangeState();
}

class _WidgetListPersonChangeState extends State<WidgetListPersonChange> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Danh sách người muốn đổi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.maintext,
          ),
        ),
        SizedBox(height: 20,),
        LayoutBuilder(builder: (context, constraints) => Column(
          children: [
            for(int i = 0 ; i < 5 ; i++)
              WidgetItemPersonChange(
                width: constraints.maxWidth,
                change: () {

                },
                nochange: () {

                },
              ),
          ],
        ),)
      ],
    );
  }
}
