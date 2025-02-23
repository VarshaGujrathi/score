import 'package:flutter/material.dart';
import 'package:score/login_page.dart';

// Ensure the path is correct

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
                      width: 150, // Decreased width for mobile
                      height: 150, // Decreased height for mobile
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
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
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/logo2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      key: ValueKey(2),
                      width: 200, // Decreased width for mobile
                      height: 200, // Decreased height for mobile
                      child: Image.asset(
                        'assets/splash_white.png',
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          if (!_showFirstImage) // Only show button if not showing the first image
            Positioned(
              bottom: 75, // Adjusted for mobile
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Icon(Icons.arrow_forward,
                      color: Colors.white,
                      size: 18), // Reduced icon size for mobile
                  label: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14), // Reduced text size for mobile
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25), // Reduced border radius for mobile
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10), // Reduced padding for mobile
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
