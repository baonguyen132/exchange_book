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

class _PostFacebookState extends State<PostFacebook>
    with SingleTickerProviderStateMixin {
  TextEditingController titlePost = TextEditingController();
  TextEditingController descriptionPost = TextEditingController();
  bool _isLoading = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    titlePost.dispose();
    descriptionPost.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header Card ──
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cs.primary,
                        Color.lerp(cs.primary, Colors.deepPurple, 0.35)!,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withOpacity(0.30),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.campaign_rounded,
                            color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đăng bài Facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Soạn nội dung và đăng bài lên fanpage',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.78),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Form Card ──
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? cs.surface : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: cs.onSurface.withOpacity(0.06),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.18 : 0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section label — Title
                      _buildSectionLabel(
                        icon: Icons.title_rounded,
                        label: 'Tiêu đề bài viết',
                        cs: cs,
                      ),
                      const SizedBox(height: 10),
                      WidgetTextFieldCustom(
                        controller: titlePost,
                        textInputType: TextInputType.text,
                        hint: "Nhập tiêu đề",
                        iconData: Icons.drive_file_rename_outline,
                      ),

                      const SizedBox(height: 22),

                      // Section label — Description
                      _buildSectionLabel(
                        icon: Icons.article_outlined,
                        label: 'Nội dung mô tả',
                        cs: cs,
                      ),
                      const SizedBox(height: 10),
                      WidgetTextFieldArea(
                        controller: descriptionPost,
                        textInputType: TextInputType.multiline,
                        hint: "Nhập mô tả bài viết...",
                        iconData: Icons.format_indent_decrease,
                        onChange: (value) {},
                      ),

                      const SizedBox(height: 14),

                      // Character counter
                      Align(
                        alignment: Alignment.centerRight,
                        child: ListenableBuilder(
                          listenable: descriptionPost,
                          builder: (_, __) {
                            final len = descriptionPost.text.length;
                            return Text(
                              '$len ký tự',
                              style: TextStyle(
                                fontSize: 12,
                                color: cs.onSurface.withOpacity(0.35),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // ── Action Buttons ──
                Row(
                  children: [
                    // Cancel button
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    descriptionPost.clear();
                                    titlePost.clear();
                                  });
                                },
                          icon: Icon(Icons.refresh_rounded,
                              size: 20,
                              color: _isLoading
                                  ? cs.onSurface.withOpacity(0.25)
                                  : cs.onSurface.withOpacity(0.6)),
                          label: Text(
                            'Xoá nội dung',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _isLoading
                                  ? cs.onSurface.withOpacity(0.25)
                                  : cs.onSurface.withOpacity(0.7),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                            side: BorderSide(
                              color: cs.onSurface.withOpacity(
                                  _isLoading ? 0.06 : 0.12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Post button
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 52,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: [
                                cs.primary,
                                Color.lerp(
                                    cs.primary, Colors.deepPurple, 0.30)!,
                              ],
                            ),
                            boxShadow: _isLoading
                                ? []
                                : [
                                    BoxShadow(
                                      color: cs.primary.withOpacity(0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    postFaceBook(
                                      titlePost.text,
                                      descriptionPost.text,
                                      () {
                                        setState(() {
                                          _isLoading = false;
                                          descriptionPost.clear();
                                          titlePost.clear();
                                        });
                                        toast("Upload post successful");
                                      },
                                      (error) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        print(error);
                                        toast("Upload failed: $error");
                                      },
                                    );
                                  },
                            icon: const Icon(Icons.send_rounded,
                                color: Colors.white, size: 20),
                            label: const Text(
                              'Đăng bài',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          // ── Loading Overlay ──
          if (_isLoading)
            AnimatedOpacity(
              opacity: _isLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: Container(
                color: (isDark ? Colors.black : Colors.black)
                    .withOpacity(isDark ? 0.55 : 0.35),
                child: Center(
                  child: ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36, vertical: 30),
                      decoration: BoxDecoration(
                        color: isDark ? cs.surface : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: cs.primary.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.5,
                              color: cs.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Đang đăng bài...',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Vui lòng chờ trong giây lát',
                            style: TextStyle(
                              color: cs.onSurface.withOpacity(0.45),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Helper: Section Label ──
  Widget _buildSectionLabel({
    required IconData icon,
    required String label,
    required ColorScheme cs,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: cs.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: cs.primary),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: cs.onSurface.withOpacity(0.7),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
