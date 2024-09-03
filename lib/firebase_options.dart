// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// Add your Firebase configuration here.
const FirebaseOptions firebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyClfi2-KJp4kqavFj10CXXYrVFtzqkdoOY',
  appId: '1:840644939816:android:9ebad8131c2bf9fe10651d',
  messagingSenderId: '840644939816',
  projectId: 'score-f2649',
);

Future<FirebaseApp> initializeFirebase() async {
  return await Firebase.initializeApp(options: firebaseOptions);
}
