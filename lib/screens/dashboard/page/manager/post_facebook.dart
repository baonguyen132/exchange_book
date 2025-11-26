import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/service/assistant_service.dart';
import 'package:flutter/material.dart';

import '../../../../util/widget_text_field_area.dart';
import '../../../../util/widget_text_field_custom.dart';

class PostFacebook extends StatefulWidget {
  const PostFacebook({super.key});

  @override
  State<PostFacebook> createState() => _PostFacebookState();
}

class _PostFacebookState extends State<PostFacebook> {

  TextEditingController titlePost = TextEditingController();
  TextEditingController descriptionPost = TextEditingController();

  @override
  void dispose() {
    titlePost.dispose();
    descriptionPost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(

        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,


            children: [
              // Header
              LayoutBuilder(builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.95, 0.95), // subtle bottom-right
                      radius: 1.0,
                      colors: [
                        Colors.white,
                        Colors.blue.withOpacity(0.5),
                      ],
                      stops: const [0.9, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Đăng bài lên facebook',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Điền đầy đủ thông tin dưới ây',
                            style: TextStyle(
                                fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      )
                  ),
                );
              }),
              const SizedBox(height: 16,),
              WidgetTextFieldCustom(
                controller: titlePost,
                textInputType: TextInputType.text,
                hint: "Nhập tiêu đề",
                iconData: Icons.drive_file_rename_outline,
              ),
              const SizedBox(height: 16,),
              WidgetTextFieldArea(
                controller: descriptionPost,
                textInputType: TextInputType.multiline,
                hint: "Nhập mô tả",
                iconData: Icons.format_indent_decrease,
                onChange: (value) {},
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          descriptionPost.clear();
                          titlePost.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Huỷ',style: TextStyle(color: Colors.black54)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        postFaceBook(titlePost.text, descriptionPost.text, () {
                          toast("Upload post successful");

                          setState(() {
                            descriptionPost.clear();
                            titlePost.clear();
                          });

                        }, (error) {
                          print(error);
                        },);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Đăng bài' , style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
