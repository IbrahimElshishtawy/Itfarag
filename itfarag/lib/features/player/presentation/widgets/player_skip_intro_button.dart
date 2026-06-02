import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class PlayerSkipIntroButton extends StatelessWidget {
  final Duration currentPosition;
  final VoidCallback onSkipIntro;

  const PlayerSkipIntroButton({
    super.key,
    required this.currentPosition,
    required this.onSkipIntro,
  });

  @override
  Widget build(BuildContext context) {
    if (currentPosition >= const Duration(minutes: 2)) return const SizedBox();

    return Align(
      alignment: Alignment.centerRight,
      child: GlassCard(
        borderRadius: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        fillOpacity: 0.2,
        child: GestureDetector(
          onTap: onSkipIntro,
          child: const Text(
            'Skip Intro ⏩',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
