import 'package:flutter/material.dart';
import 'tasks/task17.dart';  // Import task17.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Assignment Portal',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StudentAssignmentPortal(),
      debugShowCheckedModeBanner: false,
    );
  }
}