import 'dart:math';
import 'package:flutter/material.dart';

class LoginDesktop extends StatefulWidget {
  final Widget formLogin;
  const LoginDesktop({super.key, required this.formLogin});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _backgroundController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_backgroundController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(const Color(0xFF1E3C72), const Color(0xFF2A5298),
                      0.5 + 0.5 * sin(_backgroundAnimation.value * 2 * pi))!,
                  Color.lerp(const Color(0xFF2A5298), const Color(0xFF1E3C72),
                      0.5 + 0.5 * cos(_backgroundAnimation.value * 2 * pi))!,
                  Color.lerp(
                      const Color(0xFF1E3C72),
                      const Color(0xFF2A5298),
                      0.5 +
                          0.5 * sin(_backgroundAnimation.value * 2 * pi + pi))!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Floating circles background
                ...List.generate(5, (index) => _buildFloatingCircle(index)),

                // Main content
                Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: min(
                              1200, MediaQuery.of(context).size.width * 0.9),
                          height: min(
                              700, MediaQuery.of(context).size.height * 0.85),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 20),
                                blurRadius: 40,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.1),
                                offset: const Offset(0, 10),
                                blurRadius: 30,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Row(
                              children: [
                                // Left side - Illustration
                                Expanded(
                                  child: Transform.translate(
                                    offset:
                                        Offset(_slideAnimation.value * 200, 0),
                                    child: _buildLeftSide(),
                                  ),
                                ),

                                // Right side - Form
                                Expanded(
                                  child: Transform.translate(
                                    offset:
                                        Offset(-_slideAnimation.value * 200, 0),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: widget.formLogin,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingCircle(int index) {
    final sizes = [80.0, 120.0, 60.0, 100.0, 40.0];
    final positions = [
      const Alignment(-0.8, -0.6),
      const Alignment(0.9, -0.8),
      const Alignment(-0.9, 0.8),
      const Alignment(0.7, 0.6),
      const Alignment(0.0, -0.9),
    ];

    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Align(
            alignment: positions[index],
            child: Transform.translate(
              offset: Offset(
                20 * sin(_backgroundAnimation.value * 2 * pi + index),
                20 * cos(_backgroundAnimation.value * 2 * pi + index),
              ),
              child: Container(
                width: sizes[index],
                height: sizes[index],
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeftSide() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade100,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hero Icon
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade800],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_stories,
              size: 80,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 40),

          // Brand Text
          Text(
            "Book Swap",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Connect, Share, and Exchange Books with Fellow Readers",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue.shade700,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Features
          ...List.generate(3, (index) => _buildFeature(index)),
        ],
      ),
    );
  }

  Widget _buildFeature(int index) {
    final features = [
      {"icon": Icons.people_outline, "text": "Connect with readers"},
      {"icon": Icons.swap_horiz, "text": "Exchange books easily"},
      {"icon": Icons.favorite_outline, "text": "Discover new favorites"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              features[index]["icon"] as IconData,
              color: Colors.blue.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            features[index]["text"] as String,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
