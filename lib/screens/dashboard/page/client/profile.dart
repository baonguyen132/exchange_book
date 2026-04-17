import 'package:exchange_book/screens/dashboard/page/client/cubit/profile/profile_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/introduce_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/product_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_book/model/user_modal.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  late TabController _tabController;
  String newPath = "";

  void loadImage() async {
    final path = await UserModel.exportImageAva(
        context.read<ProfileCubit>().state.user.id.toString());
    if (!mounted) return;
    setState(() {
      newPath = path;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ProfileCubit>().loadingData();
    loadImage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colorScheme.background,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildSliverAppBar(context, state, isMobile),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildProfileHeader(context, state, isMobile),
                      const SizedBox(height: 16),
                      _buildStatsSection(context, state, isMobile),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                _buildStickyTabBar(context, isMobile),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildScrollableTabContent(ProductProfile(list: state.list ?? [])),
                _buildScrollableTabContent(IntroduceProfile(
                  height: null,
                  weight: double.infinity,
                  margin: 16,
                )),
                _buildScrollableTabContent(_buildActivityTab(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildScrollableTabContent(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: child,
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ProfileState state, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      expandedHeight: isMobile ? 180 : 240,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: colorScheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Cover Image
            Image.network(
              'https://images.unsplash.com/photo-1507842217343-583bb7270b66?q=80&w=2000&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_note, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileState state, bool isMobile) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Transform.translate(
            offset: const Offset(0, -50),
            child: Column(
              children: [
                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: isMobile ? 50 : 65,
                    backgroundColor: colorScheme.primary.withOpacity(0.1),
                    backgroundImage: newPath.isNotEmpty ? NetworkImage(newPath) : null,
                    child: newPath.isEmpty
                        ? Icon(Icons.person, size: isMobile ? 50 : 65, color: colorScheme.primary)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  state.user.name ?? 'Người dùng',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                if (state.user.email != null)
                  Text(
                    state.user.email!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeaderAction(
                  context,
                  icon: Icons.edit,
                  label: 'Chỉnh sửa',
                  isPrimary: true,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                _buildHeaderAction(
                  context,
                  icon: Icons.settings_outlined,
                  label: 'Cài đặt',
                  isPrimary: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    if (isPrimary) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, ProfileState state, bool isMobile) {
    final stats = [
      {'label': 'Sách đăng', 'value': '${state.list?.length ?? 0}', 'icon': Icons.book_outlined},
      {'label': 'Trao đổi', 'value': '24', 'icon': Icons.swap_horiz},
      {'label': 'Điểm', 'value': state.user.point ?? '0', 'icon': Icons.stars_rounded},
      {'label': 'Yêu thích', 'value': '18', 'icon': Icons.favorite_border},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = (constraints.maxWidth - (isMobile ? 16 : 48)) / (isMobile ? 2 : 4);
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: stats.map((stat) => _buildStatCard(context, stat, cardWidth)).toList(),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, Map<String, dynamic> stat, double width) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(stat['icon'] as IconData, color: colorScheme.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            stat['value'] as String,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat['label'] as String,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStickyTabBar(BuildContext context, bool isMobile) {
    final colorScheme = Theme.of(context).colorScheme;
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: _tabController,
          indicatorColor: colorScheme.primary,
          indicatorWeight: 3,
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurface.withOpacity(0.5),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: 'Sách'),
            Tab(text: 'Giới thiệu'),
            Tab(text: 'Hoạt động'),
          ],
        ),
        Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildActivityTab(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final activities = [
      {
        'icon': Icons.swap_horiz,
        'title': 'Trao đổi sách "Doraemon"',
        'subtitle': 'với Nguyễn Văn A',
        'time': '2 giờ trước',
      },
      {
        'icon': Icons.favorite,
        'title': 'Yêu thích "One Piece"',
        'subtitle': 'của Trần Thị B',
        'time': '1 ngày trước',
      },
      {
        'icon': Icons.auto_stories,
        'title': 'Đăng sách mới "Naruto"',
        'subtitle': 'Thể loại: Manga',
        'time': '3 ngày trước',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: activities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.primary.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primary.withOpacity(0.1),
                child: Icon(activity['icon'] as IconData, color: colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activity['subtitle'] as String,
                      style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                activity['time'] as String,
                style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4), fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this.backgroundColor);

  final TabBar _tabBar;
  final Color backgroundColor;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

