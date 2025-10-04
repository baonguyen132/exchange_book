import 'package:exchange_book/screens/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/login/widget/widget_button_login.dart';
import 'package:exchange_book/screens/login/widget/widget_finger.dart';
import 'package:exchange_book/screens/login/widget/widget_navigator_to_sign_up.dart';
import 'package:exchange_book/util/widget_text_field_custom.dart';

import '../../../data/ConstraintData.dart';
import '../../../util/widget_text_field_password_custom.dart';

class FormLogin extends StatefulWidget {
  bool isDesktop;
  FormLogin({super.key, this.isDesktop = false});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> with TickerProviderStateMixin {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().loadingUsername();

    final state = context.read<LoginCubit>().state;
    emailController = TextEditingController(text: state.email);
    passwordController = TextEditingController(text: state.password);

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.blue.shade50.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Enhanced Header với gradient và animation
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade600,
                              Colors.blue.shade700,
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          size: 45,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade800],
                        ).createShader(bounds),
                        child: const Text(
                          textAlign: TextAlign.center,
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        textAlign: TextAlign.center,
                        "Sách không bỏ đi-tri thức còn ở lại!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // Enhanced Form fields với spacing và styling
                Column(
                  children: [
                    WidgetTextFieldCustom(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      hint: "Email Address",
                      iconData: Icons.mail_outline_rounded,
                      onChange: (value) =>
                          context.read<LoginCubit>().changeEmail(value),
                    ),
                    const SizedBox(height: 24),
                    WidgetTextFieldPasswordCustom(
                      controller: passwordController,
                      onChange: (value) =>
                          context.read<LoginCubit>().changePassword(value),
                      isVisibility:
                          context.read<LoginCubit>().state.isVisibility,
                      changeVisibility: () =>
                          context.read<LoginCubit>().changeIsVisibility(),
                    ),

                    // Enhanced Finger authentication với better styling
                    if (!widget.isDesktop)
                      Container(
                        margin: const EdgeInsets.only(top: 28),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade50,
                              Colors.indigo.shade50,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade600,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.fingerprint_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Quick Login",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Save fingerprint for secure access",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                value: context
                                    .watch<LoginCubit>()
                                    .state
                                    .isSaveFinger,
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .changeIsSaveFinger(),
                                activeColor: Colors.blue[600],
                                checkColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 36),

                    // Enhanced Login buttons với better layout
                    Row(
                      children: [
                        Expanded(
                          flex: widget.isDesktop ? 1 : 4,
                          child: WidgetButtonLogin(
                            handle: () async {
                              UserModel? user = await UserModel.login(
                                  emailController.text,
                                  passwordController.text);

                              if (context
                                  .read<LoginCubit>()
                                  .state
                                  .isSaveFinger) {
                                UserModel.saveAccount(emailController.text,
                                    passwordController.text);
                                toast("Fingerprint saved successfully");
                              }
                              if (user != null) {
                                UserModel.saveUserData(user);
                                Navigator.pushReplacementNamed(
                                    context, "/dashboard");
                              } else {
                                toast("Login failed. Please try again.");
                              }
                            },
                          ),
                        ),
                        if (!widget.isDesktop) ...[
                          const SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade50,
                                  Colors.grey.shade100,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: WidgetFinger(
                              handle: () async {
                                // Biometric authentication code here
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // Enhanced Divider với gradient
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey.shade300,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade300,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                // Enhanced Navigation to sign up
                const WidgetNavigatorToSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
