import 'package:flutter/material.dart';
import 'splash.dart'; // Import the new splash screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: SplashPage(), // Set the SplashPage as the initial page
    );
  }
}
