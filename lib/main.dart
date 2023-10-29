import 'package:flutter/material.dart';
import 'package:toguishi/screens/authenticated/home_screen.dart';
import 'package:toguishi/screens/unauthenticated/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toguishi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = false;
    return isAuthenticated ? HomeScreen() : LoginScreen();
  }
}
