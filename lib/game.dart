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
            Navigator.pop(context); // Navigate back
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
            _buildGameButton(context, Icons.sports_soccer, 'Football', FootballPage()),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_volleyball, 'Volleyball', null),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_cricket, 'Cricket', null),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_tennis, 'Badminton', null), // Tennis icon instead of badminton
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_handball, 'Throwball', null),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.directions_run, 'Track', null),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.extension, 'Chess', null), // Extension icon as a placeholder for chess
          ],
        ),
      ),
    );
  }

  // Helper method to create game buttons with icon and text
  Widget _buildGameButton(BuildContext context, IconData icon, String label, Widget? navigateToPage) {
    return ElevatedButton.icon(
      onPressed: () {
        if (navigateToPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateToPage),
          );
        }
      },
      icon: Icon(
        icon,
        color: Colors.black, // Icon color black
        size: 20, // Reduce the icon size
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black, // Text color black
          fontWeight: FontWeight.bold, // Bold text
          fontSize: 16, // Reduce the font size
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white, // Text and icon color black
        padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
      ),
    );
  }
}
