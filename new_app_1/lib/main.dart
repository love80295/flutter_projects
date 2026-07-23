import 'package:flutter/material.dart';
import 'tasks/task14.dart';  // Import the task14.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Student Portal',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const CollegeStudentPortal(),  // Use the main widget from task14
      debugShowCheckedModeBanner: false,
    );
  }
}