// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:score/game.dart';

import 'create_account_page.dart'; // Import the create account page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image above Welcome Text
              Image.asset(
                'assets/scorelogin.png', // Path to the image asset
                height: 100, // Adjust height as needed
                width: 200, // Adjust width as needed
              ),
              SizedBox(height: 20), // Space between image and Welcome text

              // Welcome Text
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 35, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40), // Space between text and form

              // Username TextField
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), // Icon for username
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20), // Space between username and password field

              // Password TextField
              TextField(
                obscureText: true, // Hide password text
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), // Icon for password
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20), // Space between password field and button

              // Login Button
              ElevatedButton(
                onPressed: () {
                  {
                    // Navigate to the GamePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button color
                  padding: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Adjust padding as needed
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 18, // Adjust font size as needed
                  ),
                ),
              ),
              SizedBox(
                  height: 20), // Space between button and create account link

              // Create Account Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Haven't created an account? ",
                    style: TextStyle(
                      fontSize: 16, // Adjust font size as needed
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to the Create Account page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAccountPage()),
                      );
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.blue, // Link color
                        fontSize: 16, // Adjust font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
