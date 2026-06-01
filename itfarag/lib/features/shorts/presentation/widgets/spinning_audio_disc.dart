// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SpinningAudioDisc extends StatefulWidget {
  const SpinningAudioDisc({Key? key}) : super(key: key);

  @override
  State<SpinningAudioDisc> createState() => _SpinningAudioDiscState();
}

class _SpinningAudioDiscState extends State<SpinningAudioDisc> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationController,
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.black54,
        child: CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.music_note_rounded, color: Colors.black87, size: 12),
        ),
      ),
    );
  }
}
