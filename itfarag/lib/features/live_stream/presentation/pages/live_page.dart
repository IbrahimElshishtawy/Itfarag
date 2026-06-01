// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';

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

  final List<String> _chatMessages = [
    'Wow, the video stream looks incredibly crisp! 🔥',
    'Best cyberpunk live stream in Flutter! 🦾',
    'Greetings from Cairo! 🇪🇬',
    'Is this using WebSockets? So fast!',
  ];

  final TextEditingController _commentController = TextEditingController();

  // Stable public Tears of Steel HLS broadcast stream
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
    _commentController.dispose();
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
    
    // Theme-dependent colors for unified premium feel
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black54;
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
              // Broadcast Active Live Video Player View Card
              Container(
                height: 240,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      // Video Render Frame
                      _isInitialized
                          ? GestureDetector(
                              onTap: _togglePlay,
                              child: AspectRatio(
                                aspectRatio: _playerController.value.aspectRatio,
                                child: VideoPlayer(_playerController),
                              ),
                            )
                          : const Center(
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
                            ),

                      // Dark overlay at top for better view of LIVE badges
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 60,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black54, Colors.transparent],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      // Live & Viewers badges
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('LIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.remove_red_eye_rounded, color: Colors.white, size: 10),
                                  SizedBox(width: 4),
                                  Text('14.2K', style: TextStyle(fontSize: 10, color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Manual Play/Pause Quick Tap overlay
                      if (_isInitialized && !_isPlaying)
                        GestureDetector(
                          onTap: _togglePlay,
                          child: Container(
                            color: Colors.black45,
                            child: const Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white24,
                                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40),
                              ),
                            ),
                          ),
                        ),

                      // Buffering Indicator overlay
                      if (_isBuffering)
                        Container(
                          color: Colors.black26,
                          child: const Center(
                            child: CircularProgressIndicator(color: AppColors.secondary),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Live Broadcaster Profile info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=60'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ahmed Esports Live Broadcast', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text('Playing Cyber City 2026', style: TextStyle(color: subTextColor, fontSize: 12)),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent, 
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.star_rounded, size: 16),
                      label: const Text('Subscribe'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              Divider(color: dividerColor, height: 24, thickness: 1),

              // Chat Message list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    final isOdd = index % 2 == 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                              isOdd 
                                ? 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60'
                                : 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100&auto=format&fit=crop&q=60'
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'User_$index: ',
                                style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 13),
                                children: [
                                  TextSpan(
                                    text: _chatMessages[index],
                                    style: TextStyle(color: textColor.withOpacity(0.8), fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Input bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: 'Join the chat...',
                          hintStyle: TextStyle(color: subTextColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: textColor.withOpacity(0.15)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: AppColors.accent),
                          ),
                          filled: true,
                          fillColor: textColor.withOpacity(0.05),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        if (_commentController.text.isNotEmpty) {
                          setState(() {
                            _chatMessages.add(_commentController.text);
                            _commentController.clear();
                          });
                        }
                      },
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.accent,
                        child: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
