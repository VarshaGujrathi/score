import 'package:flutter/material.dart';
import 'package:score/football.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate backflu
          },
        ),
        backgroundColor: Colors.white, // AppBar background color white
        elevation: 0, // Remove shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGameButton(context, Icons.sports_soccer, 'Football'),
            SizedBox(height: 16),
            _buildGameButton(context, Icons.sports_volleyball, 'Volleyball'),
            SizedBox(height: 16),
            _buildGameButton(context, Icons.sports_cricket, 'Cricket'),
            SizedBox(height: 16),
            _buildGameButton(context, Icons.sports_tennis,
                'Badminton'), // Tennis icon instead of badminton
            SizedBox(height: 16),
            _buildGameButton(context, Icons.sports_handball, 'Throwball'),
            SizedBox(height: 16),
            _buildGameButton(context, Icons.directions_run, 'Track'),
            SizedBox(height: 16),
            _buildGameButton(context, Icons.extension,
                'Chess'), // Extension icon as a placeholder for chess
          ],
        ),
      ),
    );
  }

  // Helper method to create game buttons with icon and text
  Widget _buildGameButton(BuildContext context, IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigate to the GamePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FootballPage()),
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
        backgroundColor: Colors.white, // Text and icon color black
        padding:
            EdgeInsets.symmetric(vertical: 16), // Add padding for better UI
      ),
    );
  }
}
