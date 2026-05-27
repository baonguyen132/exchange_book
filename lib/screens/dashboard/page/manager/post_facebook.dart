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
  bool _isLoading = false;

  @override
  void dispose() {
    titlePost.dispose();
    descriptionPost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtextColor = isDark ? Colors.white54 : Colors.black54;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? [
                                const Color(0xFF1E1E2C),
                                Color.lerp(const Color(0xFF1E1E2C), theme.primaryColor, 0.08)!,
                              ]
                            : [
                                Colors.white,
                                Color.lerp(Colors.white, theme.primaryColor, 0.06)!,
                              ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(isDark ? 0.15 : 0.10),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.send_rounded, color: theme.primaryColor, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đăng bài lên facebook',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Điền đầy đủ thông tin dưới đây',
                                  style: TextStyle(fontSize: 13, color: subtextColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isLoading ? null : () {
                            setState(() {
                              descriptionPost.clear();
                              titlePost.clear();
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(color: isDark ? Colors.white24 : Colors.black26),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text('Huỷ', style: TextStyle(color: subtextColor)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                Color.lerp(theme.primaryColor, Colors.purple, 0.2)!,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : () {
                              setState(() {
                                _isLoading = true;
                              });
                              postFaceBook(titlePost.text, descriptionPost.text, () {
                                setState(() {
                                  _isLoading = false;
                                  descriptionPost.clear();
                                  titlePost.clear();
                                });
                                toast("Upload post successful");
                              }, (error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                print(error);
                                toast("Upload failed: $error");
                              },);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Đăng bài' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: (isDark ? Colors.black : Colors.white).withOpacity(0.4),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: theme.primaryColor),
                      const SizedBox(height: 14),
                      Text(
                        'Đang đăng bài...',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      )
    );
  }
}
