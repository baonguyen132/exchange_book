import 'dart:math';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/data/SideMenuData.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/assistant.dart';
import 'package:exchange_book/screens/dashboard/page/client/manage_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/question.dart';
import 'package:exchange_book/screens/dashboard/page/client/tranfer_for_user.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/article_carousel.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/card_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/contribute_ideas.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/information_user.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/why_exchange.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage/widget_sign_up_book.dart';
import 'package:exchange_book/screens/scan/scan_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../model/book_modal.dart';
import '../../cubit/dashboard_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/home/green_knowledge_board.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UserModel userModel = UserModel(
    name: "",
    email: "",
    password: "",
    cccd: "",
    dob: "",
    gender: "",
    address: "",
    point: "",
  );

  @override
  void initState() {
    super.initState();
    userModel = context.read<DashboardCubit>().state.user;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0F1117) : const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HEADER ──────────────────────────────────────────────────
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3B5BDB),
                      const Color(0xFF4DABF7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20,
                      bottom: 0,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.04),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InformationUser(userModel: userModel),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.format_quote_rounded,
                                    color: Colors.white, size: 14),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Sách không bỏ đi – tri thức còn ở lại!',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // CardPoint overlapping header
              Transform.translate(
                offset: const Offset(0, -50),
                child: CardPoint(
                  point: userModel.point,
                  qrData: '${userModel.id}-${userModel.cccd}',
                ),
              ),

              // ── QUICK ACTIONS ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section label
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 14),
                      child: Text(
                        'Tính năng',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: isDarkMode ? Colors.white : Colors.grey.shade800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),

                    // Grid of quick actions
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final screenWidth = MediaQuery.of(context).size.width;
                        final crossAxisCount = screenWidth > 768 ? 6 : 3;
                        return GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.95,
                          children: [
                            _miniFeatureButton(
                              icon: Icons.book_outlined,
                              label: 'Đăng sách',
                              color: const Color(0xFF3B5BDB),
                              onTap: () {
                                if (userModel.id != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WidgetSignUpBook(
                                          user: userModel,
                                          insert: (bookModal) {
                                            BookModal.updateDatabaseBook(
                                              bookModal,
                                              "$location/insertBook",
                                              () {
                                                toast("Thêm thành công");
                                                context
                                                    .read<DashboardCubit>()
                                                    .exchange(
                                                        listmenu[2], true);
                                              },
                                              () {
                                                toast("Thêm không thành công");
                                              },
                                            );
                                          },
                                        ),
                                      ));
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.qr_code_scanner_rounded,
                              label: 'Quét mã',
                              color: const Color(0xFF0CA678),
                              onTap: () async {
                                if (userModel.id != null) {
                                  String data = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ScanQrCode(),
                                      ));
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TranferForUser(
                                          id: data,
                                          idUser: userModel.id.toString(),
                                        ),
                                      ));

                                  if (result) {
                                    int? currentPoint =
                                        await UserModel.loadPointData();
                                    setState(() {
                                      userModel.point =
                                          currentPoint.toString();
                                    });
                                  }
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.account_balance_wallet_rounded,
                              label: 'Quản lý ví',
                              color: const Color(0xFFE8590C),
                              onTap: () async {
                                if (userModel.id != null) {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ManagePoint(userModel: userModel),
                                      ));
                                  if (result) {
                                    int? currentPoint =
                                        await UserModel.loadPointData();
                                    setState(() {
                                      userModel.point =
                                          currentPoint.toString();
                                    });
                                  }
                                }
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.lightbulb_rounded,
                              label: 'Đóng góp',
                              color: const Color(0xFF7950F2),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ContributeIdeas(),
                                    ));
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.smart_toy_rounded,
                              label: 'Trợ lý AI',
                              color: const Color(0xFF1098AD),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Assistant(),
                                    ));
                              },
                            ),
                            _miniFeatureButton(
                              icon: Icons.quiz_rounded,
                              label: 'Quiz',
                              color: const Color(0xFFF59F00),
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Question(
                                        userModel: userModel,
                                      ),
                                    ));
                                if (result != null) {
                                  setState(() {
                                    userModel.point = result.toString();
                                  });
                                  UserModel.savePointData(result);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    // ── WHY EXCHANGE ──────────────────────────────────────
                    _sectionHeader('Tại sao nên trao đổi sách?', isDarkMode),
                    const SizedBox(height: 14),
                    const WhyExchange(),

                    const SizedBox(height: 28),

                    // ── LEADERBOARD ───────────────────────────────────────
                    const GreenKnowledgeBoard(),

                    const SizedBox(height: 28),

                    // ── ARTICLES ──────────────────────────────────────────
                    _sectionHeader('Một nét bút chì – ngàn cuốn sách được trao', isDarkMode),
                    const SizedBox(height: 14),
                    const ArticleCarousel(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF3B5BDB),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isDarkMode ? Colors.white : const Color(0xFF1A1D2E),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniFeatureButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        final isMobile = MediaQuery.of(context).size.width <= 768;

        final double internalPadding = isMobile ? 2.0 : 1.0;
        final double cellSize = constraints.maxWidth - (internalPadding * 4);
        final double iconSize = (cellSize * 0.26).clamp(20.0, 32.0);
        final double fontSize = (cellSize * 0.10).clamp(9.0, 13.0);
        final double borderRadius = 16.0;

        return Padding(
          padding: EdgeInsets.all(internalPadding),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(borderRadius),
              splashColor: color.withOpacity(0.12),
              highlightColor: color.withOpacity(0.06),
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E2030) : Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.3)
                          : color.withOpacity(0.12),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all((cellSize * 0.09).clamp(7.0, 12.0)),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: iconSize),
                    ),
                    SizedBox(height: (cellSize * 0.06).clamp(5.0, 10.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.white.withOpacity(0.85)
                              : const Color(0xFF1A1D2E),
                          fontWeight: FontWeight.w700,
                          fontSize: fontSize,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} // end of _HomeState
