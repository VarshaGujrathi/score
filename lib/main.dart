import 'package:flutter/material.dart';

import 'event_lead.dart'; // Import EventLeadPage
import 'schedule_event.dart'; // Import ScheduleEventPage
import 'splash.dart'; // Import the splash screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      initialRoute: '/', // Set initial route
      routes: {
        '/': (context) => SplashPage(),
        '/leaderboard': (context) => EventLeadPage(),
        '/schedule': (context) => ScheduleEventPage(),
      },
    );
  }
}
