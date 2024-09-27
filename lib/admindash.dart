import 'package:flutter/material.dart';

class AdminDashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.black, // Set background color if needed
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Example Section 1: User Management
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('Manage Users'),
                leading: Icon(Icons.person),
                onTap: () {
                  // Navigate to a page for managing users
                },
              ),
            ),
            SizedBox(height: 10),
            // Example Section 2: View Statistics
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('View Statistics'),
                leading: Icon(Icons.analytics),
                onTap: () {
                  // Navigate to a page for viewing statistics
                },
              ),
            ),
            SizedBox(height: 10),
            // Example Section 3: System Settings
            Card(
              elevation: 5,
              child: ListTile(
                title: Text('System Settings'),
                leading: Icon(Icons.settings),
                onTap: () {
                  // Navigate to a page for system settings
                },
              ),
            ),
            SizedBox(height: 20),
            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add logout functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set button color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
