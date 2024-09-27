import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, String> userDetails;

  ProfilePage({required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${userDetails['name'] ?? 'N/A'}'),
            SizedBox(height: 8),
            Text('Email: ${userDetails['email'] ?? 'N/A'}'),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
