// ignore_for_file: unused_import, unused_field

import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List
import 'dart:io'; // For File class
import 'package:flutter/foundation.dart' show kIsWeb; // Check if the platform is web
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Import dart:html only when running on the web
import 'dart:html' as html show FileUploadInputElement, FileReader;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _captainNameController = TextEditingController();
  final TextEditingController _captainEmailController = TextEditingController();
  final TextEditingController _captainMobileController = TextEditingController();
  final TextEditingController _teamMemberEmailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; // For mobile
  String? _imageFileWeb; // For web
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
        // Title text removed
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
              child: Text('Add Team Members'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Text color white
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 16),
            Text('Any Queries contact:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Ritika Jain : xxxxxxxx'),
            Text('Varsha Gujrathi : xxxxxxxx'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (kIsWeb) {
                  _pickImageWeb();
                } else {
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  setState(() {
                    _imageFile = pickedFile;
                    if (pickedFile != null) {
                      _imageFileWeb = null; // Reset for mobile
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You have successfully uploaded the screenshot'),
                          backgroundColor: Colors.green, // Background color green
                          behavior: SnackBarBehavior.floating, // Optional: Make the SnackBar floating
                        ),
                      );
                    }
                  });
                }
              },
              child: Text('Upload Screenshot'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black, // Text color white
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            if (_imageFile != null || _imageFileWeb != null) ...[
              SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(maxHeight: 300),
                child: kIsWeb && _imageFileWeb != null
                  ? Image.memory(
                      base64Decode(_removeDataUrlPrefix(_imageFileWeb!)),
                      fit: BoxFit.contain, // Fit the image within the container
                    )
                  : _imageFile != null
                    ? Image.file(
                        File(_imageFile!.path),
                        fit: BoxFit.contain, // Fit the image within the container
                      )
                    : Container(),
              ),
            ],
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

  // Method to pick image for web
  void _pickImageWeb() {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(files[0]);
      reader.onLoadEnd.listen((e) {
        setState(() {
          _imageFileWeb = reader.result as String; // Data URL including base64
          _imageFile = null; // Reset for web
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have successfully uploaded the screenshot'),
              backgroundColor: Colors.green, // Background color green
              behavior: SnackBarBehavior.floating, // Optional: Make the SnackBar floating
            ),
          );
        });
      });
    });
    uploadInput.click();
  }

  // Helper method to remove the data URL prefix
  String _removeDataUrlPrefix(String dataUrl) {
    final prefix = 'data:image/jpeg;base64,';
    if (dataUrl.startsWith(prefix)) {
      return dataUrl.substring(prefix.length);
    }
    return dataUrl;
  }
}
