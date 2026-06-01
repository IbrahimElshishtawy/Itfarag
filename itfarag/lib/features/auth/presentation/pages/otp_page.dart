// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/premium_button.dart';
import '../widgets/otp_input_row.dart';

class OtpPage extends StatefulWidget {
  final String phone;

  const OtpPage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Verify Your Account',
                  style: AppTypography.heading1.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter the 6-digit MFA security code sent to your phone number: ${widget.phone}',
                  style: AppTypography.bodyMedium.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                GlassCard(
                  borderRadius: 24,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OtpInputRow(
                        length: 6,
                        onChanged: (code) {
                          setState(() {
                            _verificationCode = code;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      PremiumButton(
                        text: 'Verify & Confirm',
                        onPressed: () {
                          if (_verificationCode.length == 6) {
                            // Hardcoded premium OTP verification redirecting to dashboard Home shell
                            context.go('/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter all 6 digits'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Resend Code via SMS',
                      style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
