import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import the DashboardPage class

class EventLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              'assets/scorelogin.png',
              height: 150, // Adjust height as needed
              width: 150, // Adjust width as needed
            ),
            SizedBox(height: 10), // Space between image and text

            // Welcome text
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Space between text and username field

            // Username text field
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16), // Space between username and password field

            // Password text field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20), // Space between password field and button

            // Login button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color white
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Add padding
              ),
            ),
          ],
        ),
      ),
    );
  }
}
