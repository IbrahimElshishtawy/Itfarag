// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/shimmer_loader.dart';

class Section extends StatelessWidget {
  final String title;
  final bool isLoading;
  final double height;
  final Widget child;

  const Section({
    Key? key,
    required this.title,
    required this.isLoading,
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 24, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded, 
                  size: 16, 
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: height,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ShimmerLoader(
                      width: height * 0.8,
                      height: height,
                      borderRadius: 16,
                    ),
                  ),
                )
              : child,
        ),
      ],
    );
  }
}
