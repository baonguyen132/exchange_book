import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';
import 'introduce_profile_edit.dart';
import 'introduce_profile_item.dart';

class IntroduceProfile extends StatelessWidget {
  final double? height;
  final double weight;
  final double margin;
  
  const IntroduceProfile({
    super.key, 
    this.height, 
    required this.weight, 
    required this.margin
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: weight,
      height: height,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.surface,
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contact_mail_outlined,
                  color: colorScheme.primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  "Thông tin liên hệ",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const IntroduceProfileItem(
                  text: "Facebook",
                  imageUrl: "https://cdn-icons-png.flaticon.com/512/124/124010.png",
                  link: "https://facebook.com/user",
                ),
                const SizedBox(height: 12),
                const IntroduceProfileItem(
                  text: "GitHub",
                  imageUrl: "https://cdn-icons-png.flaticon.com/512/25/25231.png",
                  link: "https://github.com/user",
                ),
                const SizedBox(height: 12),
                const IntroduceProfileItem(
                  text: "LinkedIn",
                  imageUrl: "https://cdn-icons-png.flaticon.com/512/174/174857.png",
                  link: "https://linkedin.com/in/user",
                ),
                const SizedBox(height: 24),

                // Edit button
                IntroduceProfileEdit(
                  handle: () {
                    // TODO: Handle edit
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

