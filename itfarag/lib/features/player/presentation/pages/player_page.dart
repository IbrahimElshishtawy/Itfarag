import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class PlayerPage extends StatefulWidget {
  final String id;

  const PlayerPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  double _playbackProgress = 0.35;
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Simulated hardware video playback visual
          Image.network(
            'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=1000&auto=format&fit=crop&q=80',
            fit: BoxFit.cover,
          ),
          // Player black shades overlays
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          // Controls layers
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top control bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
                        onPressed: () => context.pop(),
                      ),
                      Text(
                        'Streaming: The Cyber Edge (ID: ${widget.id})',
                        style: AppTypography.heading3.copyWith(color: Colors.white, fontSize: 16),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.subtitles_rounded, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Middle controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 40),
                      onPressed: () {
                        setState(() {
                          _playbackProgress = (_playbackProgress - 0.05).clamp(0.0, 1.0);
                        });
                      },
                    ),
                    const SizedBox(width: 32),
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      child: IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      icon: const Icon(Icons.forward_30_rounded, color: Colors.white, size: 40),
                      onPressed: () {
                        setState(() {
                          _playbackProgress = (_playbackProgress + 0.05).clamp(0.0, 1.0);
                        });
                      },
                    ),
                  ],
                ),
                // Bottom control panel
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Skip Intro Button overlay
                      Align(
                        alignment: Alignment.centerRight,
                        child: GlassCard(
                          borderRadius: 8,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          fillOpacity: 0.2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _playbackProgress = 0.55;
                              });
                            },
                            child: const Text(
                              'Skip Intro ⏩',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Progress slider row
                      Row(
                        children: [
                          const Text('12:40', style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Expanded(
                            child: Slider(
                              value: _playbackProgress,
                              onChanged: (val) {
                                setState(() {
                                  _playbackProgress = val;
                                });
                              },
                              activeColor: AppColors.primary,
                              inactiveColor: Colors.white30,
                            ),
                          ),
                          const Text('36:12', style: TextStyle(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.volume_up_rounded, color: Colors.white),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.fullscreen_exit_rounded, color: Colors.white),
                            onPressed: () => context.pop(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
