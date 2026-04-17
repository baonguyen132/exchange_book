import 'package:flutter/material.dart';
import 'package:exchange_book/screens/dashboard/widget/card/card_item.dart';
import 'package:exchange_book/theme/theme.dart';
import '../../../../../../data/ConstraintData.dart';

class ProductProfile extends StatelessWidget {
  final List<dynamic> list;
  const ProductProfile({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(Icons.auto_stories_outlined, size: 64, color: colorScheme.primary.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              "Chưa có sách nào được đăng",
              style: TextStyle(color: colorScheme.onBackground.withOpacity(0.5)),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            "Sách đã đăng",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 1.5 : 1.2,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final book = list[index];
            return _buildBookCard(context, book);
          },
        ),
      ],
    );
  }

  Widget _buildBookCard(BuildContext context, dynamic book) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CardItem(
      width: double.infinity,
      heart: true,
      link: "$location/${book[6]}",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            book[1],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow(context, Icons.inventory_2_outlined, "Số lượng: ${book[10]}"),
          const SizedBox(height: 4),
          _buildInfoRow(context, Icons.payments_outlined, "${book[4]} VND"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

