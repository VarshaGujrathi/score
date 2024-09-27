// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart'; // Use file_picker for web
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String selectedGame;

  RegisterPage({required this.selectedGame});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _captainNameController = TextEditingController();
  final TextEditingController _captainEmailController = TextEditingController();
  final TextEditingController _captainMobileController =
      TextEditingController();
  List<TextEditingController> _teamMemberControllers = [];
  PlatformFile? _screenshot; // Updated to PlatformFile for file_picker

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _screenshot = result.files.first;
      });
    }
  }

  Future<void> _submitRegistration() async {
    if (_screenshot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload a screenshot.')),
      );
      return;
    }

    try {
      // Upload screenshot to Firebase Storage
      String screenshotFileName =
          '${DateTime.now().millisecondsSinceEpoch}.png';
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('screenshots/$screenshotFileName')
          .putData(_screenshot!.bytes!); // Use bytes for web
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Store form data in Firestore
      List<String> teamMembers =
          _teamMemberControllers.map((controller) => controller.text).toList();
      await FirebaseFirestore.instance.collection('registrations').add({
        'teamName': _teamNameController.text,
        'captainName': _captainNameController.text,
        'captainEmail': _captainEmailController.text,
        'captainMobile': _captainMobileController.text,
        'teamMembers': teamMembers,
        'game': widget.selectedGame,
        'screenshotUrl': downloadUrl, // URL of the uploaded screenshot
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Register for ${widget.selectedGame}',
            style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              Text('Team Members Email:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ..._teamMemberControllers.map((controller) => _buildTextField(
                    controller: controller,
                    icon: Icons.email,
                    labelText: 'Team Member Email',
                  )),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _teamMemberControllers.add(TextEditingController());
                  });
                },
                child: Text('Add Team Members', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.upload_file, size: 18),
                label:
                    Text('Upload Screenshot', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitRegistration,
                child:
                    Text('Submit Registration', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(),
      ),
    );
  }
}
