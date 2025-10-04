import 'package:flutter/material.dart';
import 'package:exchange_book/model/user_modal.dart';

class UserProfileCardInformation extends StatefulWidget {
  final UserModel user;
  const UserProfileCardInformation({super.key, required this.user});

  @override
  State<UserProfileCardInformation> createState() =>
      _UserProfileCardInformationState();
}

class _UserProfileCardInformationState
    extends State<UserProfileCardInformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          widget.user.name ?? 'Người dùng',
          style: TextStyle(
            fontSize: 28,
            color: Colors.blue.shade800,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        // Email
        if (widget.user.email != null && widget.user.email!.isNotEmpty) ...[
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 16,
                color: Colors.blue.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                widget.user.email!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade600,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],

        // Info cards
        ..._buildInfoCards(),

        const SizedBox(height: 24),

        // Action buttons
        _buildActionButtons(),
      ],
    );
  }

  List<Widget> _buildInfoCards() {
    final infoItems = [
      {
        'icon': Icons.stars,
        'label': 'Điểm tích lũy',
        'value': widget.user.point ?? '0',
        'color': Colors.amber.shade600,
      },
      {
        'icon': Icons.badge,
        'label': 'Căn cước',
        'value': widget.user.cccd ?? 'Chưa cập nhật',
        'color': Colors.green.shade600,
      },
      {
        'icon': Icons.person,
        'label': 'Giới tính',
        'value': widget.user.gender ?? 'Chưa cập nhật',
        'color': Colors.purple.shade600,
      },
      {
        'icon': Icons.location_on,
        'label': 'Địa chỉ',
        'value': widget.user.address ?? 'Chưa cập nhật',
        'color': Colors.red.shade600,
      },
    ];

    return infoItems
        .map((item) => _buildInfoCard(
              icon: item['icon'] as IconData,
              label: item['label'] as String,
              value: item['value'] as String,
              color: item['color'] as Color,
            ))
        .toList();
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Edit profile
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Chỉnh sửa'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Settings
            },
            icon: const Icon(Icons.settings, size: 18),
            label: const Text('Cài đặt'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade600,
              side: BorderSide(color: Colors.blue.shade600),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
