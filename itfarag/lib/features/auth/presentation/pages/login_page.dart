import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'ETFARAG',
                          style: AppTypography.heading1.copyWith(
                            fontSize: 32,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: AppColors.premiumGradient,
                              ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Unlock unlimited movies, series, and Watch Parties',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySmall.copyWith(color: Colors.white54),
                      ),
                      const SizedBox(height: 48),
                      GlassCard(
                        borderRadius: 24,
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Sign In',
                                style: AppTypography.heading2.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 24),
                              // Phone/Email Field
                              TextFormField(
                                controller: _phoneController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Phone Number or Email',
                                  labelStyle: const TextStyle(color: Colors.white60),
                                  prefixIcon: const Icon(Icons.phone_iphone_rounded, color: AppColors.primary),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: AppColors.primary),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number or email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(color: Colors.white60),
                                  prefixIcon: const Icon(Icons.lock_rounded, color: AppColors.accent),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                      color: Colors.white60,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: AppColors.accent),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: AppTypography.bodySmall.copyWith(color: AppColors.secondary),
                                  ),
                                ),
                              ),
                              PremiumButton(
                                text: 'Sign In',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Developer / Administrator Bypass Verification Check
                                    if (_phoneController.text == 'admin' &&
                                        _passwordController.text == 'developer_pass_2026') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('💎 Welcome Back Developer! Bypass Mode Enabled.'),
                                          backgroundColor: AppColors.secondary,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                      context.go('/home');
                                      return;
                                    }

                                    // Standard User MFA OTP Verification
                                    context.pushNamed(
                                      RouteNames.otp,
                                      pathParameters: {'phone': _phoneController.text},
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: AppColors.secondary.withOpacity(0.5), width: 1.5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                icon: const Icon(Icons.developer_mode_rounded, color: AppColors.secondary, size: 18),
                                label: const Text(
                                  'تسجيل دخول المطور (Developer Login)',
                                  style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                onPressed: () {
                                  _phoneController.text = 'admin';
                                  _passwordController.text = 'developer_pass_2026';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('💎 Welcome Back Developer! Bypass Mode Enabled.'),
                                      backgroundColor: AppColors.secondary,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  context.go('/home');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white60),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Sign Up Now',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
