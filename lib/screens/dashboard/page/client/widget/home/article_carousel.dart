import 'package:flutter/material.dart';

class ArticleCarousel extends StatefulWidget {
  const ArticleCarousel({super.key});

  @override
  State<ArticleCarousel> createState() => _ArticleCarouselState();
}

class _ArticleCarouselState extends State<ArticleCarousel> {
  final List<Map<String, String>> _articles = [
    {
      'title': 'Lợi ích của việc đọc sách mỗi ngày',
      'desc': 'Đọc sách giúp mở rộng kiến thức và cải thiện tư duy.',
      'images': 'assets/images/anhsach1.jpeg',
      'url': 'https://vnexpress.net',
    },
    {
      'title': 'Cách chọn sách phù hợp với lứa tuổi',
      'desc': 'Gợi ý cách lựa chọn sách phù hợp với từng độ tuổi.',
      'images': 'assets/images/anhsach2.jpeg',
      'url': 'https://tuoitre.vn',
    },
    {
      'title': 'Trao đổi sách – văn hóa đẹp cần lan tỏa',
      'desc': 'Trao đổi sách giúp tiết kiệm và kết nối cộng đồng.',
      'images': 'assets/images/anhsach3.jpeg',
      'url': 'https://thanhnien.vn',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 148,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: _articles.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final a = _articles[index];
          return GestureDetector(
            onTap: () {
              // Navigation to ArticleWebView preserved
            },
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E2030) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black38
                        : Colors.grey.shade200,
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                    ),
                    child: Image.asset(
                      a['images'] ?? 'assets/images/anhsach1.jpeg',
                      width: 100,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.broken_image_rounded,
                            color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  // Text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            a['title'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              height: 1.3,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF1A1D2E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            a['desc'] ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.4,
                              color: isDarkMode
                                  ? Colors.white54
                                  : Colors.grey.shade500,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B5BDB).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Đọc thêm',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3B5BDB),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
