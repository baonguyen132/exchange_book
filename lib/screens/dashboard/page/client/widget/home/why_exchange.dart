import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WhyExchange extends StatefulWidget {
  const WhyExchange({super.key});

  @override
  State<WhyExchange> createState() => _WhyExchangeState();
}

class _WhyExchangeState extends State<WhyExchange> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        // flat card: no shadow
        boxShadow: [],
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 12, horizontal: 12),
      child: Column(
        children: [
          _promoRow(
            icon: Icons.eco,
            title: 'Bảo vệ môi trường',
            desc:
            'Trao đổi sách giúp giảm lãng phí tài nguyên và bảo vệ môi trường.',
            theme: theme,
          ),
          const Divider(
              height: 24,
              thickness: 1,
              color: Color(0xFFF0F0F0)),
          _promoRow(
            icon: Icons.groups,
            title: 'Kết nối cộng đồng',
            desc:
            'Tạo cơ hội giao lưu, chia sẻ tri thức giữa mọi người.',
            theme: theme,
          ),
          const Divider(
              height: 24,
              thickness: 1,
              color: Color(0xFFF0F0F0)),
          _promoRow(
            icon: Icons.lightbulb,
            title: 'Tiết kiệm chi phí',
            desc:
            'Tiếp cận nhiều đầu sách mới mà không tốn nhiều chi phí.',
            theme: theme,
          ),
        ],
      ),
    );
  }
  Widget _promoRow({
    required IconData icon,
    required String title,
    required String desc,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: theme.primaryColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                desc,
                style:
                theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
