import 'package:flutter/material.dart';

import 'select.dart'; // Ensure the path is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFirstImage = true;

  @override
  void initState() {
    super.initState();

    // Delay of 2 seconds to switch from the first image to the second
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showFirstImage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _showFirstImage ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: _showFirstImage
                  ? Container(
                      key: ValueKey(1),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/logo2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      key: ValueKey(2),
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        'assets/splash_white.png',
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          if (!_showFirstImage) // Only show button if not showing the first image
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectPage()),
                    );
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
