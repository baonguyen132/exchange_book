import 'package:flutter/material.dart';

import 'info_chip.dart';

class UserCard extends StatelessWidget {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final String cid;
  final VoidCallback onGrant;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.cid,
    required this.onGrant,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final roleColor = isAdmin
        ? const Color(0xFFFF9800)
        : const Color(0xFF4CAF50);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? cs.surface : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: cs.onSurface.withOpacity(0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.16 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row: Avatar + Name + Role Badge ──
          Row(
            children: [
              // Avatar
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cs.primary.withOpacity(0.75),
                      Color.lerp(cs.primary, Colors.deepPurple, 0.4)!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Name + Email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        color: cs.onSurface.withOpacity(0.50),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Role Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: roleColor.withOpacity(isDark ? 0.15 : 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAdmin
                          ? Icons.admin_panel_settings_rounded
                          : Icons.person_rounded,
                      size: 14,
                      color: roleColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isAdmin ? 'Admin' : 'Client',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: roleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ── Info chips ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: cs.onSurface.withOpacity(isDark ? 0.04 : 0.025),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InfoChip(
                  icon: Icons.tag_rounded,
                  label: 'ID',
                  value: id,
                  cs: cs,
                ),
                const SizedBox(width: 20),
                InfoChip(
                  icon: Icons.badge_outlined,
                  label: 'CID',
                  value: cid,
                  cs: cs,
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ── Action buttons ──
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: onGrant,
                    icon: Icon(Icons.verified_user_rounded,
                        size: 17, color: Colors.green.shade500),
                    label: Text(
                      'Cấp quyền',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.green.withOpacity(isDark ? 0.25 : 0.20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          Colors.green.withOpacity(isDark ? 0.06 : 0.03),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete_outline_rounded,
                        size: 17, color: Colors.red.shade400),
                    label: Text(
                      'Xoá',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade400,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.red.withOpacity(isDark ? 0.25 : 0.20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          Colors.red.withOpacity(isDark ? 0.06 : 0.03),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
