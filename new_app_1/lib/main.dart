import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'tasks/task19.dart';  // Import task19.dart

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register the Student adapter
  Hive.registerAdapter(StudentAdapter());
  
  // Open the box (this will create it if it doesn't exist)
  await Hive.openBox<Student>('students');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive CRUD Students',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HiveCrudScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}