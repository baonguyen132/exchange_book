import 'package:flutter/material.dart';

class WidgetItemPersonChange extends StatefulWidget {
  Function () change ;
  Function () nochange ;
  double width ;

  WidgetItemPersonChange({super.key , required this.width , required this.change , required this.nochange});

  @override
  State<WidgetItemPersonChange> createState() => _WidgetItemPersonChangeState();
}

class _WidgetItemPersonChangeState extends State<WidgetItemPersonChange> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 15),
      width: widget.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(width: 1 , color: Colors.blue.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://nld.mediacdn.vn/2020/9/7/anh-1-15994611977581569666831.gif",
                  ),
                  fit: BoxFit.cover,

                )
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Họ và tên",
                  style: const TextStyle(
                    fontSize: 20 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.change();
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.nochange();
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ))
        ],
      ),
    );
  }
}
