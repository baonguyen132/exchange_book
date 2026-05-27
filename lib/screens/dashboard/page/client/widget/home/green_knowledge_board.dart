import 'package:flutter/material.dart';

class GreenKnowledgeBoard extends StatefulWidget {
  const GreenKnowledgeBoard({super.key});

  @override
  State<GreenKnowledgeBoard> createState() => _GreenKnowledgeBoardState();
}

class _GreenKnowledgeBoardState extends State<GreenKnowledgeBoard> {
  final List<Map<String, dynamic>> champions = [
    {'name': 'Nguyễn Văn Anh', 'books': 15},
    {'name': 'Trần Thị Ly', 'books': 12},
    {'name': 'Lê Văn Thiện', 'books': 11},
  ];

  final List<Map<String, dynamic>> heroes = [
    {'name': 'Võ Tài', 'books': 12},
    {'name': 'Trần Thiện', 'books': 11},
    {'name': 'Bùi Thị Ly', 'books': 10},
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDarkMode ? const Color(0xFF1E2030) : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFF0CA678),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Bảng Vinh Danh Tri Thức Xanh',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: isDarkMode ? Colors.white : Colors.grey.shade800,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0CA678).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Top 3',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0CA678),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Two column cards — IntrinsicHeight makes them equal
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildColumn(
                  icon: '🏆',
                  title: 'Nhà Vô Địch Cho Đi',
                  subtitle: 'Tặng sách nhiều nhất',
                  data: champions,
                  cardBg: cardBg,
                  isDarkMode: isDarkMode,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildColumn(
                  icon: '♻️',
                  title: 'Người Hùng Tái Sử Dụng',
                  subtitle: 'Dùng sách cũ nhiều nhất',
                  data: heroes,
                  cardBg: cardBg,
                  isDarkMode: isDarkMode,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumn({
    required String icon,
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> data,
    required Color cardBg,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black38 : Colors.grey.shade200,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row: icon + title on same line
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(icon, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isDarkMode ? Colors.white : Colors.grey.shade800,
                    height: 1.3,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 10),

          // User items
          ...data.asMap().entries.map((e) {
            return _buildUserItem(
              rank: e.key + 1,
              name: e.value['name'],
              books: e.value['books'],
              isDarkMode: isDarkMode,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUserItem({
    required int rank,
    required String name,
    required int books,
    required bool isDarkMode,
  }) {
    final rankColors = {
      1: const Color(0xFFF59F00),
      2: const Color(0xFF868E96),
      3: const Color(0xFFE8590C),
    };
    final rankColor = rankColors[rank] ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.white.withOpacity(0.05)
            : rankColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: rankColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: rankColor.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.grey.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      size: 10,
                      color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$books cuốn',
                      style: TextStyle(
                        fontSize: 10,
                        color: isDarkMode ? Colors.white54 : Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Icon(
            rank == 1
                ? Icons.emoji_events_rounded
                : rank == 2
                    ? Icons.military_tech_rounded
                    : Icons.star_rounded,
            size: 14,
            color: rankColor,
          ),
        ],
      ),
    );
  }
}
