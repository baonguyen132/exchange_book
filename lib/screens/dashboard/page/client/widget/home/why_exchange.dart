import 'package:flutter/material.dart';

class WhyExchange extends StatelessWidget {
  const WhyExchange({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF1E2030) : Colors.white;

    final items = [
      {
        'icon': Icons.eco_rounded,
        'color': const Color(0xFF0CA678),
        'bg': const Color(0xFFEBFBEE),
        'darkBg': const Color(0xFF0CA678),
        'title': 'Bảo vệ môi trường',
        'desc': 'Giảm lãng phí tài nguyên, góp phần xanh hóa hành tinh.',
      },
      {
        'icon': Icons.groups_rounded,
        'color': const Color(0xFF3B5BDB),
        'bg': const Color(0xFFEDF2FF),
        'darkBg': const Color(0xFF3B5BDB),
        'title': 'Kết nối cộng đồng',
        'desc': 'Giao lưu chia sẻ tri thức giữa mọi người.',
      },
      {
        'icon': Icons.savings_rounded,
        'color': const Color(0xFFF59F00),
        'bg': const Color(0xFFFFF9DB),
        'darkBg': const Color(0xFFF59F00),
        'title': 'Tiết kiệm chi phí',
        'desc': 'Tiếp cận nhiều sách mới mà không tốn quá nhiều.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black38 : Colors.grey.shade200,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? (item['darkBg'] as Color).withOpacity(0.18)
                            : item['bg'] as Color,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xFF1A1D2E),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['desc'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              color: isDarkMode
                                  ? Colors.white60
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: item['color'] as Color,
                      ),
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 18,
                  endIndent: 18,
                  color: isDarkMode ? Colors.white10 : Colors.grey.shade100,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
