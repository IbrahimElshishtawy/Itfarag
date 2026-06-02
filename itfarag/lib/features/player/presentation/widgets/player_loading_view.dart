import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PlayerLoadingView extends StatelessWidget {
  const PlayerLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 16),
          Text(
            'Connecting to Streaming Server...',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
