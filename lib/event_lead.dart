import 'package:flutter/material.dart';

class EventLeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Leaderboard will be displayed here.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
