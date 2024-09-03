import 'package:flutter/material.dart';

import 'game.dart'; // Import the game.dart file

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedBranch = 'AI-DS'; // Default value for dropdown
  bool _obscurePassword = true; // To toggle password visibility
  String _dob = ''; // Variable to store Date of Birth

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Icon
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
            ),
            SizedBox(height: 20), // Space between icon and form

            // Form
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Username TextField
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Email TextField
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Password TextField with Show/Hide Functionality
                    TextFormField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
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
                    SizedBox(height: 20),

                    // Date of Birth
                    TextFormField(
                      controller: TextEditingController(
                          text: _dob), // Set initial value
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        hintText: 'Date of Birth',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true, // Prevent user input
                      onTap: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            _dob = "${selectedDate.toLocal()}"
                                .split(' ')[0]; // Format date as needed
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),

                    // Study Year TextField
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        hintText: 'Study Year',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your study year';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // College ID TextField
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.card_membership),
                        hintText: 'College ID',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your college ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Branch Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedBranch,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance), // Updated icon
                        border: OutlineInputBorder(),
                      ),
                      items: <String>['AI-DS', 'IT', 'COMPS', 'ETC']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBranch = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your branch';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Mobile Number TextField
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Mobile Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Navigate to the GamePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
