import 'package:flutter/material.dart';
import 'tasks/task12.dart';  // Import from tasks folder

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Preferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const UserPreferencesScreen(),  // Using the screen from task12.dart
      debugShowCheckedModeBanner: false,
    );
  }
}