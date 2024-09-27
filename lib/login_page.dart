import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:score/EventCreate.dart';
import 'package:score/admindash.dart'; // Import the AdminDashPage
import 'package:score/eventdash.dart'; // Import the EventDashPage
import 'package:score/game.dart'; // Import the GamePage

import 'create_account_page.dart'; // Import the create account page for Student

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedRole = 'Student'; // Default role
  bool _obscurePassword = true; // To toggle password visibility
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  bool _isLoading = false; // To show loading indicator

  // List of allowed admin emails
  final List<String> _allowedAdminEmails = [
    'ritika.jain@somaiya.edu',
    'varsha.g@somaiya.edu',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey, // Attach the key to the form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image above Welcome Text
                Image.asset(
                  'assets/scorelogin.png', // Path to the image asset
                  height: 90, // Adjust height as needed
                  width: 150, // Adjust width as needed
                ),
                SizedBox(height: 10), // Space between image and Welcome text

                // Welcome Text
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 35, // Adjust font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // Space between text and role selection

                // Role Selection Dropdown
                DropdownButton<String>(
                  value: _selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                  items: <String>['Student', 'Event Head', 'Admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text('Select Role'),
                ),
                SizedBox(height: 20), // Space between role dropdown and form

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), // Icon for email
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.endsWith('@somaiya.edu')) {
                      return 'Email must end with @somaiya.edu';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20), // Space between email and password field

                // Password TextField with Show/Hide Functionality
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock), // Icon for password
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Space between password field and button

                // Loading Indicator
                if (_isLoading) CircularProgressIndicator(),

                // Login Button
                if (!_isLoading)
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          // Check if the email is allowed for Admin role
                          if (_selectedRole == 'Admin' &&
                              !_allowedAdminEmails
                                  .contains(_emailController.text.trim())) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Unauthorized Admin Email.'),
                              ),
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }

                          // Sign in with Firebase Authentication
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          // Navigate to the respective page based on role
                          if (userCredential.user != null) {
                            switch (_selectedRole) {
                              case 'Student':
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GamePage()),
                                );
                                break;
                              case 'Event Head':
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventDashPage()),
                                );
                                break;
                              case 'Admin':
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminDashPage()),
                                );
                                break;
                              default:
                                break;
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          // Handle Firebase-specific errors
                          String errorMessage;
                          switch (e.code) {
                            case 'user-not-found':
                              errorMessage = 'No user found for that email.';
                              break;
                            case 'wrong-password':
                              errorMessage = 'Wrong password provided.';
                              break;
                            case 'invalid-email':
                              errorMessage = 'Invalid email address.';
                              break;
                            default:
                              errorMessage = 'Sign in failed: ${e.message}';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Button color
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12), // Reduced padding
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Reduced font size
                      ),
                    ),
                  ),
                SizedBox(
                    height: 20), // Space between button and create account link

                // Create Account Link (Visible for Student or Event Head role)
                if (_selectedRole == 'Student' || _selectedRole == 'Event Head')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Haven't created an account? ",
                        style: TextStyle(
                          fontSize: 14, // Reduced font size
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the correct Create Account page based on role
                          if (_selectedRole == 'Student') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()),
                            );
                          } else if (_selectedRole == 'Event Head') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventCreatePage()),
                            );
                          }
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.blue, // Link color
                            fontSize: 14, // Reduced font size
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
      ),
    );
  }
}
