import 'package:exchange_book/screens/dashboard/page/manager/cubit/manage/manage_user_cubit.dart';
import 'package:exchange_book/screens/dashboard/widget/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/manage_user/user_card.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  @override
  void initState() {
    super.initState();
    context.read<ManageUserCubit>().loading();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<ManageUserCubit, ManageUserState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                      strokeWidth: 3, color: cs.primary),
                ),
                const SizedBox(height: 14),
                Text('Đang tải...',
                    style: TextStyle(
                        color: cs.onSurface.withOpacity(0.5), fontSize: 13)),
              ],
            ),
          ),
          loaded: (page, list) => Column(
            children: [
              // ── Header ──
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                        color: cs.primary.withOpacity(0.28),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(Icons.people_alt_rounded,
                            color: Colors.white, size: 26),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quản lý người dùng',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${list.length} người dùng trên trang $page',
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
              ),

              // ── User Cards List ──
              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: cs.primary.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.person_off_rounded,
                                  size: 44,
                                  color: cs.onSurface.withOpacity(0.3)),
                            ),
                            const SizedBox(height: 16),
                            Text('Không có người dùng nào',
                                style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: list.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final data = list[index];
                          return UserCard(
                            id: data[0].toString(),
                            name: data[1]?.toString() ?? '',
                            email: data[2]?.toString() ?? '',
                            isAdmin: data[4] == 5,
                            cid: data[5]?.toString() ?? '',
                            onGrant: () {
                              // xử lý cấp quyền
                            },
                            onDelete: () {
                              // xử lý xóa
                            },
                          );
                        },
                      ),
              ),

              // ── Pagination ──
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  height: 50,
                  child: Pagination(
                    back: () {
                      if (page != 1) {
                        context.read<ManageUserCubit>().change("-", page);
                      }
                    },
                    next: () {
                      if (list.isNotEmpty) {
                        context.read<ManageUserCubit>().change("+", page);
                      }
                    },
                    indexCurrent: page,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

