import 'package:flutter/material.dart';
import 'tasks/task15.dart';  // Import task15.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration Form',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StudentRegistrationForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}