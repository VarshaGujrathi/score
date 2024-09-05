// ignore_for_file: unused_import, unused_field, avoid_web_libraries_in_flutter, use_key_in_widget_constructors

import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Keeping for potential future use

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _captainNameController = TextEditingController();
  final TextEditingController _captainEmailController = TextEditingController();
  final TextEditingController _captainMobileController = TextEditingController();
  List<TextEditingController> _teamMemberControllers = [];

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: _teamNameController,
              icon: Icons.group,
              labelText: 'Team Name',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _captainNameController,
              icon: Icons.person,
              labelText: 'Captain Name',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _captainEmailController,
              icon: Icons.email,
              labelText: 'Captain Email',
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _captainMobileController,
              icon: Icons.phone,
              labelText: 'Captain Mobile Number',
            ),
            SizedBox(height: 16),
            Text('Team Members Email:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ..._teamMemberControllers.map((controller) => _buildTextField(
              controller: controller,
              icon: Icons.email,
              labelText: 'Team Member Email',
            )).toList(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _teamMemberControllers.add(TextEditingController());
                });
              },
              child: Text('Add Team Members', style: TextStyle(fontSize: 14)), // Reduced font size
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Button color black
                padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
              ),
            ),
            SizedBox(height: 16),
            Text('Any Queries contact:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Ritika Jain : xxxxxxxx'),
            Text('Varsha Gujrathi : xxxxxxxx'),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // No action since we are removing gallery functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Upload Screenshot button clicked'),
                    backgroundColor: Colors.green, // Background color green
                    behavior: SnackBarBehavior.floating, // Optional: Make the SnackBar floating
                  ),
                );
              },
              icon: Icon(Icons.upload_file, size: 18), // Reduced icon size
              label: Text('Upload Screenshot', style: TextStyle(fontSize: 14)), // Reduced font size
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Button color black
                padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a text field with icon
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black), // Icon color black
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black), // Label color black
        border: OutlineInputBorder(),
      ),
    );
  }
}
