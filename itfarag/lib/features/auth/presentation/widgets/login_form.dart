import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';
import 'developer_bypass_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final labelColor = isDark ? Colors.white60 : Colors.black54;
    final borderColor = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15);
    final fillColor = (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05);

    return GlassCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            // Phone/Email Field
            TextFormField(
              controller: _phoneController,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Phone Number or Email',
                labelStyle: TextStyle(color: labelColor),
                prefixIcon: const Icon(Icons.phone_iphone_rounded, color: AppColors.primary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: fillColor,
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
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: labelColor),
                prefixIcon: const Icon(Icons.lock_rounded, color: AppColors.accent),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    color: labelColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.accent),
                ),
                filled: true,
                fillColor: fillColor,
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
            DeveloperBypassButton(
              phoneController: _phoneController,
              passwordController: _passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
