import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'LeaderboardPage.dart';
import 'SchedulePage.dart';
import 'create_account_page.dart';
import 'event_Lead_page.dart';
import 'eventlogin.dart';
import 'login_page.dart';
import 'schedule_event.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized

  // Initialize Firebase and handle errors
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAdOjztaMJWrtucPLw2jC4v_NaVNT83JFE",
        appId: "1:788919178012:android:c495d2038c0b1ed99860d9",
        messagingSenderId: "788919178012",
        projectId: "score-ae9a5",
        storageBucket: "score-ae9a5.appspot.com",
      ),
    );
    runApp(const MyApp()); // If Firebase initializes successfully, run MyApp
  } catch (e) {
    print("Firebase initialization error: $e");
    runApp(const ErrorApp()); // If there's an error, run the error screen
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      initialRoute: '/', // Set initial route to splash screen
      routes: {
        '/': (context) => SplashPage(),
        '/loginpage': (context) => LoginPage(), // Route to login page
        '/eventloginpage': (context) =>
            EventLoginPage(), // Route to event login
        '/createaccountpage': (context) =>
            CreateAccountPage(), // Route to create account
        '/leaderboardpage': (context) =>
            LeaderboardPage(), // Route to leaderboard
        '/schedulepage': (context) => SchedulePage(), // Route to schedule page
        '/eventlead': (context) => EventLeadPage(), // Route to event lead
        '/scheduleevent': (context) =>
            ScheduleEventPage(), // Route to schedule event
      },
    );
  }
}

// ErrorApp class to show if Firebase initialization fails
class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Error initializing Firebase')),
      ),
    );
  }
}
