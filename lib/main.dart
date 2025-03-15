import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/signin.dart';  // Make sure this import is correct

void main() async {
  // Ensure Widgets are initialized before Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase before running the app
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyA9l9GxE1NPXv6EurAkUI1encC90xWwh0Q",
        appId: "1:344915311135:android:395f6e7cd067f9a76af32a",
        messagingSenderId: "344915311135",
        projectId: "wastemanagementsystem-b0b0b",
  ),
  );
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Disable the debug banner
      title: 'EcoTrack',  // Set the title of the app
      theme: ThemeData(
        primarySwatch: Colors.green,  // App theme color (adjust as needed)
      ),
      home: SignInScreen(),  // The starting screen of your app
    );
  }
}
