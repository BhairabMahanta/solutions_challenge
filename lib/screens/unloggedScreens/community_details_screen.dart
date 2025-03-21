import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatelessWidget {
  final String communityName;

  CommunityDetailScreen({required this.communityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // ✅ Dark background
      appBar: AppBar(
        title: Text(communityName),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Work in Progress!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
