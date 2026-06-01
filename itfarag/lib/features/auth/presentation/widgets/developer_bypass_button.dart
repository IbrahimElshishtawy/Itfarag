// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class DeveloperBypassButton extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const DeveloperBypassButton({
    Key? key,
    required this.phoneController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
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
        phoneController.text = 'admin';
        passwordController.text = 'developer_pass_2026';
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('💎 Welcome Back Developer! Bypass Mode Enabled.'),
            backgroundColor: AppColors.secondary,
            duration: Duration(seconds: 2),
          ),
        );
        context.go('/home');
      },
    );
  }
}
