import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/shared/widgets/glass_card.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final List<String> _chatMessages = [
    'Wow, the video stream looks incredibly crisp! 🔥',
    'Best cyberpunk live stream in Flutter! 🦾',
    'Greetings from Cairo! 🇪🇬',
    'Is this using WebSockets? So fast!',
  ];

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.darkBackgroundGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Broadcast View Card
              Container(
                height: 240,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1542204172-e7052809a936?w=800&auto=format&fit=crop&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Live & Viewers details
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
                    Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        icon: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 28),
                        onPressed: () {},
                      ),
                    ),
                  ],
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
                        children: const [
                          Text('Ahmed Esports Live Broadcast', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('Playing Cyber City 2026', style: TextStyle(color: Colors.white60, fontSize: 12)),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white),
                      icon: const Icon(Icons.star_rounded, size: 16),
                      label: const Text('Subscribe'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white12, height: 24, thickness: 1),
              // Chat Message list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=60'),
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
                                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.normal),
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
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Join the chat...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: const BorderSide(color: AppColors.accent),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
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
