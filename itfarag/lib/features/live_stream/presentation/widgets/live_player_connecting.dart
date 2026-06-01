import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LivePlayerConnecting extends StatelessWidget {
  const LivePlayerConnecting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 12),
          Text(
            'Connecting to Broadcast Stream...',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
