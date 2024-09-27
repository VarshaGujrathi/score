import 'package:flutter/material.dart';

// Import your profile and other pages here
import 'register.dart';

// Dummy function to simulate fetching user details
Future<Map<String, String>> fetchUserDetails() async {
  // Simulate a network delay
  await Future.delayed(Duration(seconds: 2));
  // Return dummy user details
  return {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    // Add more fields as needed
  };
}

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _showMenu(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () async {
              // Fetch user details
              final userDetails = await fetchUserDetails();
              // Navigate to ProfilePage with user details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(userDetails: userDetails),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGameButton(context, Icons.sports_soccer, 'Football'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_volleyball, 'Volleyball'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_cricket, 'Cricket'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_tennis, 'Badminton'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.sports_handball, 'Throwball'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.directions_run, 'Track'),
            SizedBox(height: 12),
            _buildGameButton(context, Icons.extension, 'Chess'),
            SizedBox(height: 20), // Add space at the bottom
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameButton(BuildContext context, IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RegisterPage(selectedGame: label), // Pass the game label
          ),
        );
      },
      icon: Icon(icon, color: Colors.black, size: 20),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.leaderboard, color: Colors.black),
              title: Text('Leaderboard', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: Colors.black),
              title: Text('Schedule', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.rule, color: Colors.black),
              title: Text('Rules', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RulesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.emoji_events, color: Colors.black),
              title: Text('Winner', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WinnerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.black),
              title: Text('History', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

// Updated ProfilePage class to display user details
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

// Dummy pages for demonstration
class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: Text('Leaderboard Page'),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: Text('Schedule Page'),
      ),
    );
  }
}

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
      ),
      body: Center(
        child: Text('Rules Page'),
      ),
    );
  }
}

class WinnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Winner'),
      ),
      body: Center(
        child: Text('Winner Page'),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Center(
        child: Text('History Page'),
      ),
    );
  }
}
