import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/background_form.dart';

class SignUpDesktop extends StatefulWidget {
  final Function() backLogin;
  final Widget form;

  const SignUpDesktop({
    super.key,
    required this.backLogin,
    required this.form,
  });

  @override
  State<SignUpDesktop> createState() => _SignUpDesktopState();
}

class _SignUpDesktopState extends State<SignUpDesktop>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade700,
              Colors.indigo.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: min(1200, MediaQuery.of(context).size.width * 0.9),
                height: min(700, MediaQuery.of(context).size.height * 0.85),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.blue.shade50.withOpacity(0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      spreadRadius: -5,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left Panel - Illustration
                    Expanded(
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade600,
                                Colors.blue.shade700,
                                Colors.indigo.shade600,
                              ],
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Background Pattern
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0.1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/pattern.png'),
                                        repeat: ImageRepeat.repeat,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Content
                              Padding(
                                padding: const EdgeInsets.all(50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.auto_stories_rounded,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    const Text(
                                      "Join Our\nReading Community",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Connect with fellow book lovers and discover your next favorite read",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Back Button
                              Positioned(
                                top: 30,
                                left: 30,
                                child: BackgroundForm(
                                  handle: () => widget.backLogin(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Right Panel - Form
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(50),
                        child: SingleChildScrollView(
                          child: widget.form,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
