import 'package:flutter/material.dart';

class GreenKnowledgeBoard extends StatefulWidget {
  const GreenKnowledgeBoard({super.key});

  @override
  State<GreenKnowledgeBoard> createState() => _GreenKnowledgeBoardState();
}

class _GreenKnowledgeBoardState extends State<GreenKnowledgeBoard> {
  // Mock data - chỉ top 3
  final List<Map<String, dynamic>> champions = [
    {
      'name': 'Nguyễn Văn Anh',
      'books': 15,
    },
    {
      'name': 'Trần Thị Ly',
      'books': 12,
    },
    {
      'name': 'Lê Văn Thiện',
      'books': 11,
    },
  ];

  final List<Map<String, dynamic>> heroes = [
    {
      'name': 'Võ Tài',
      'books': 12,
    },
    {
      'name': 'Trần Thiện',
      'books': 11,
    },
    {
      'name': 'Bùi Thị Ly',
      'books': 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [
                  Colors.green.withOpacity(0.15),
                  Colors.teal.withOpacity(0.15),
                ]
              : [
                  Colors.green.shade50,
                  Colors.teal.shade50,
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.green.withOpacity(0.2) : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.eco_rounded,
                  color: isDarkMode ? Colors.green.shade300 : Colors.green.shade700,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bảng Vinh Danh Tri Thức Xanh",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.green.shade300 : Colors.green.shade800,
                      ),
                    ),
                    Text(
                      "Top 3 người đóng góp cho cộng đồng",
                      style: TextStyle(
                        fontSize: 10,
                        color: isDarkMode ? Colors.green.shade400 : Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 2 columns với kích thước bằng nhau
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Column 1: Champions - flex = 1 (50%)
                Expanded(
                  flex: 1,
                  child: _buildColumn(
                    title: "🏆 Nhà Vô Địch Cho Đi",
                    subtitle: "Thiện nguyện nhiều nhất",
                    data: champions,
                    color: Colors.amber,
                    theme: theme,
                    isDarkMode: isDarkMode,
                  ),
                ),

                const SizedBox(width: 8),

                // Column 2: Heroes - flex = 1 (50%)
                Expanded(
                  flex: 1,
                  child: _buildColumn(
                    title: "♻️ Người Hùng Tái Sử Dụng",
                    subtitle: "Sử dụng sách cũ nhiều nhất",
                    data: heroes,
                    color: Colors.blue,
                    theme: theme,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn({
    required String title,
    required String subtitle,
    required List<Map<String, dynamic>> data,
    required MaterialColor color,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity, // Đảm bảo chiếm hết width được phân bổ
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Chỉ chiếm height cần thiết
        children: [
          // Column header
          Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? color.shade300 : color.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 8,
                    color: isDarkMode ? color.shade400 : color.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Top 3 list
          ...data.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return _buildUserItem(
              rank: index + 1,
              name: user['name'],
              books: user['books'],
              color: color,
              theme: theme,
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
    required MaterialColor color,
    required ThemeData theme,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDarkMode ? color.withOpacity(0.1) : color.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 20,
            height: 30,
            decoration: BoxDecoration(
              color: _getRankColor(rank),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _getRankColor(rank).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.tertiary,
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
                      color: isDarkMode ? color.shade300 : color.shade600,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "$books cuốn",
                      style: TextStyle(
                        fontSize: 8,
                        color: isDarkMode ? color.shade300 : color.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Medal icon for top 3
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: _getRankColor(rank).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              _getRankIcon(rank),
              color: _getRankColor(rank),
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber.shade600; // Gold
      case 2:
        return Colors.grey.shade500; // Silver
      case 3:
        return Colors.orange.shade600; // Bronze
      default:
        return Colors.blue.shade400;
    }
  }

  IconData _getRankIcon(int rank) {
    switch (rank) {
      case 1:
        return Icons.emoji_events_rounded; // Trophy
      case 2:
        return Icons.military_tech_rounded; // Medal
      case 3:
        return Icons.star_rounded; // Star
      default:
        return Icons.person_rounded;
    }
  }
}
