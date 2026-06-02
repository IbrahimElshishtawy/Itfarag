// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
          child: Icon(icon, color: isDark ? Colors.white70 : Colors.black87, size: 18),
        ),
        title: Text(
          title, 
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87, 
            fontSize: 14, 
            fontWeight: FontWeight.bold
          )
        ),
        subtitle: Text(
          subtitle, 
          style: TextStyle(
            color: isDark ? Colors.white54 : Colors.black54, 
            fontSize: 11
          )
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded, 
          color: isDark ? Colors.white30 : Colors.black38, 
          size: 14
        ),
        onTap: onTap,
      ),
    );
  }
}
