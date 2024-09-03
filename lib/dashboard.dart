import 'package:flutter/material.dart';
import 'userdash.dart'; // Import UserDashPage
import 'eventdash.dart'; // Import EventDashPage

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // User Dashboard Card
              GestureDetector(
                onTap: () {
                  // Navigate to UserDashPage when the card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDashPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 32, color: Colors.black),
                      SizedBox(height: 8),
                      Text(
                        'User Dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Event Dashboard Card
              GestureDetector(
                onTap: () {
                  // Navigate to EventDashPage when the card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventDashPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event, size: 32, color: Colors.black),
                      SizedBox(height: 8),
                      Text(
                        'Event Dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
