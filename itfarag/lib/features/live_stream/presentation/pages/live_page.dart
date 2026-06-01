// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/live_player_card.dart';
import '../widgets/live_broadcaster_row.dart';
import '../widgets/live_chat_section.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late VideoPlayerController _playerController;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;

  static const String _liveStreamUrl =
      'https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8';

  @override
  void initState() {
    super.initState();
    _initializeLivePlayer();
  }

  void _initializeLivePlayer() {
    _playerController = VideoPlayerController.networkUrl(Uri.parse(_liveStreamUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _playerController.play();
            _playerController.setLooping(true);
            _isPlaying = true;
          });
        }
      });

    _playerController.addListener(_videoListener);
  }

  void _videoListener() {
    if (_playerController.value.isBuffering != _isBuffering) {
      setState(() {
        _isBuffering = _playerController.value.isBuffering;
      });
    }
  }

  @override
  void dispose() {
    _playerController.removeListener(_videoListener);
    _playerController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (!_isInitialized) return;
    setState(() {
      if (_isPlaying) {
        _playerController.pause();
        _isPlaying = false;
      } else {
        _playerController.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white12 : Colors.black12;
    
    final bgGradient = isDark 
        ? AppColors.darkBackgroundGradient 
        : [const Color(0xFFF2F3F8), const Color(0xFFE3E5EE)];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bgGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LivePlayerCard(
                isInitialized: _isInitialized,
                isPlaying: _isPlaying,
                isBuffering: _isBuffering,
                controller: _playerController,
                onTogglePlay: _togglePlay,
              ),
              LiveBroadcasterRow(
                broadcasterName: 'Ahmed Esports Live Broadcast',
                broadcastTitle: 'Playing Cyber City 2026',
                avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=60',
                onSubscribe: () {},
              ),
              Divider(color: dividerColor, height: 24, thickness: 1),
              const Expanded(
                child: LiveChatSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
