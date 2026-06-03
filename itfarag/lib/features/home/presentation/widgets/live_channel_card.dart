import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class LiveChannelItem {
  final String name;
  final String nameAr;
  final String currentProgram;
  final String currentProgramAr;
  final String viewers;
  final String logoUrl;

  const LiveChannelItem({
    required this.name,
    required this.nameAr,
    required this.currentProgram,
    required this.currentProgramAr,
    required this.viewers,
    required this.logoUrl,
  });
}

class LiveChannelCard extends StatelessWidget {
  final LiveChannelItem channel;
  final VoidCallback onTap;

  const LiveChannelCard({
    super.key,
    required this.channel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final name = isArabic ? channel.nameAr : channel.name;
    final program = isArabic ? channel.currentProgramAr : channel.currentProgram;
    final viewersText = isArabic ? '${channel.viewers} مشاهد' : '${channel.viewers} watching';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 14),
        child: GlassCard(
          borderRadius: 20,
          padding: const EdgeInsets.all(12),
          fillOpacity: 0.08,
          borderOpacity: 0.12,
          child: Stack(
            children: [
              // Pulser LIVE badge in the corner
              Positioned(
                top: 0,
                right: isArabic ? null : 0,
                left: isArabic ? 0 : null,
                child: const _LiveBadge(),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Channel Logo
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        channel.logoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.darkSurface,
                            child: const Icon(
                              Icons.tv_rounded,
                              color: AppColors.secondary,
                              size: 28,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Channel Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 4),
                        // Channel Name
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Current Live Program
                        Text(
                          program,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).hintColor.withOpacity(0.85),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        // Viewers count
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye_rounded,
                              color: AppColors.secondary,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              viewersText,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveBadge extends StatefulWidget {
  const _LiveBadge();

  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final double scale = 0.95 + _pulseController.value * 0.05;
        return Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.8 + _pulseController.value * 0.2),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4 * _pulseController.value),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'LIVE',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
