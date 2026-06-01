// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class CastListItem extends StatelessWidget {
  final String actorName;
  final String imageUrl;

  const CastListItem({
    Key? key,
    required this.actorName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 6),
          Text(
            actorName, 
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
