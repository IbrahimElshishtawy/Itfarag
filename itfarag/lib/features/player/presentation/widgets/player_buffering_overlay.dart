import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PlayerBufferingOverlay extends StatelessWidget {
  final bool isBuffering;

  const PlayerBufferingOverlay({
    Key? key,
    required this.isBuffering,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isBuffering) return const SizedBox();

    return Container(
      color: Colors.black38,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.secondary),
      ),
    );
  }
}
