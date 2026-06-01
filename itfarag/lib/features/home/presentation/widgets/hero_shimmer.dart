// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/shimmer_loader.dart';

class HeroShimmer extends StatelessWidget {
  const HeroShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ShimmerLoader(
        width: double.infinity,
        height: 380,
        borderRadius: 24,
      ),
    );
  }
}
