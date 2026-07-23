import 'package:flutter/material.dart';
import 'tasks/task13.dart'; // Import the file containing all screens

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Information Navigator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      // Define named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/editCourse': (context) => const EditCourseScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}