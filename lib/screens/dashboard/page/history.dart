import 'package:flutter/material.dart';
import 'package:project_admin/screens/dashboard/page/widget/history/widget_button_custom.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int frame = 1 ;

  Widget getFrame() {
    if(frame == 1 ) {
      return Container(
        color: Colors.red,
        height: 200,
      );
    }
    else if(frame == 2) {
      return Container(
        color: Colors.blue,
        height: 200,
      );
    }
    else {
      return Container(
        color: Colors.green,
        height: 200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Container(
            child: Wrap(
              alignment: MediaQuery.of(context).size.width <= 500 ? WrapAlignment.center : WrapAlignment.start,
              children: [
                WidgetButtonCustom(
                    handle: () {
                      setState(() {
                        frame = 1 ;
                      });
                    },
                    text: "Sản phẩm của bạn"
                ),
                WidgetButtonCustom(
                    handle: () {
                      setState(() {
                        frame = 2 ;
                      });
                    },
                    text: "Đã đổi"
                ),
                WidgetButtonCustom(
                    handle: () {
                      setState(() {
                        frame = 3 ;
                      });
                    },
                    text: "Đang yêu câu"
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: getFrame(),
            )
        )
      ],
    );
  }
}
