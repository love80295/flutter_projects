import 'package:flutter/material.dart';
import 'tasks/task16.dart';  // Import task16.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Portal',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StudentInformationPortal(),
      debugShowCheckedModeBanner: false,
    );
  }
}