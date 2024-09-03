import 'package:flutter/material.dart';
import 'package:score/LeaderboardPage';
import 'package:score/SchedulePage.dart';
import 'package:score/register.dart'; 

class FootballPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        backgroundColor: Colors.white, // AppBar background color white
        elevation: 0, // Remove shadow
        // Title text color black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFootballButton(context, Icons.person, 'Registration', RegisterPage()),
            SizedBox(height: 16),
            _buildFootballButton(context, Icons.leaderboard, 'Leaderboard', LeaderboardPage()),
            SizedBox(height: 16),
            _buildFootballButton(context, Icons.schedule, 'Schedule', SchedulePage()), // Navigate to SchedulePage
            SizedBox(height: 16),
            _buildFootballButton(context, Icons.book, 'Rulebook', RegisterPage()), // Replace with actual page
            SizedBox(height: 16),
            _buildFootballButton(context, Icons.emoji_events, 'Winner', RegisterPage()), // Replace with actual page
          ],
        ),
      ),
    );
  }

  // Helper method to create football buttons with icon and text
  Widget _buildFootballButton(
      BuildContext context, IconData icon, String label, Widget page) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigate to the specified page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(
        icon,
        color: Colors.black, // Icon color black
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black, // Text color black
          fontWeight: FontWeight.bold, // Bold text
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // Button background color white
        padding:
            EdgeInsets.symmetric(vertical: 16), // Add padding for better UI
      ),
    );
  }
}
