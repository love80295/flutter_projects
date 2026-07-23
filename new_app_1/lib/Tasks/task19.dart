import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Student Model
@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final int id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String course;
  
  @HiveField(3)
  int age;

  Student({
    required this.id,
    required this.name,
    required this.course,
    required this.age,
  });
}

// Student Adapter
class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    return Student(
      id: reader.readInt(),
      name: reader.readString(),
      course: reader.readString(),
      age: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.course);
    writer.writeInt(obj.age);
  }
}

// ============ HOME SCREEN ============
class HiveCrudScreen extends StatefulWidget {
  const HiveCrudScreen({super.key});

  @override
  State<HiveCrudScreen> createState() => _HiveCrudScreenState();
}

class _HiveCrudScreenState extends State<HiveCrudScreen> {
  late Box<Student> studentBox;
  bool isInitialized = false;
  int nextId = 1;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    try {
      // Open the Hive box
      studentBox = await Hive.openBox<Student>('students');
      
      // Initialize with sample data if empty
      if (studentBox.isEmpty) {
        await _addSampleData();
      }
      
      setState(() {
        isInitialized = true;
      });
    } catch (e) {
      print('Error initializing Hive: $e');
      setState(() {
        isInitialized = true;
      });
    }
  }

  Future<void> _addSampleData() async {
    final students = [
      Student(id: 1, name: 'Sudarshan', course: 'BCA', age: 20),
      Student(id: 2, name: 'Love', course: 'B.Tech', age: 21),
      Student(id: 3, name: 'Tanishq', course: 'MBA', age: 23),
      Student(id: 4, name: 'Madhav', course: 'MCA', age: 22),
      Student(id: 5, name: 'Aman', course: 'BBA', age: 19),
    ];

    for (var student in students) {
      await studentBox.put(student.id, student);
    }
    nextId = 6;
  }

  Future<void> _addStudent(String name, String course, int age) async {
    final student = Student(
      id: nextId,
      name: name,
      course: course,
      age: age,
    );
    await studentBox.put(nextId, student);
    setState(() {
      nextId++;
    });
  }

  Future<void> _updateStudent(Student student) async {
    await studentBox.put(student.id, student);
    setState(() {});
  }

  Future<void> _deleteStudent(int id) async {
    await studentBox.delete(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Hive CRUD Students',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hive CRUD Students',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: studentBox.listenable(),
          builder: (context, Box<Student> box, _) {
            if (box.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 80,
                      color: Colors.deepPurple.shade200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Students Found',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _addSampleData();
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Add Sample Data'),
                    ),
                  ],
                ),
              );
            }

            final students = box.values.toList();
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return _buildStudentCard(student);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStudentDialog();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStudentCard(Student student) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.deepPurple,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${student.course} | Age: ${student.age} | ID: ${student.id}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                // Edit Button
                IconButton(
                  onPressed: () {
                    _navigateToUpdateScreen(student);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  tooltip: 'Edit Student',
                ),
                // Delete Button
                IconButton(
                  onPressed: () {
                    _showDeleteConfirmation(student);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Delete Student',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToUpdateScreen(Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStudentScreen(student: student),
      ),
    );

    // If updated student data is returned, update it in Hive
    if (result != null && result is Student) {
      await _updateStudent(result);
    }
  }

  void _showDeleteConfirmation(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: Text(
            'Are you sure you want to delete ${student.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteStudent(student.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${student.name} deleted successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final courseController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final course = courseController.text.trim();
                final age = int.tryParse(ageController.text.trim());

                if (name.isNotEmpty && course.isNotEmpty && age != null) {
                  _addStudent(name, course, age);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Student added successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields correctly!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

// ============ UPDATE STUDENT SCREEN ============
class UpdateStudentScreen extends StatefulWidget {
  final Student student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  late TextEditingController nameController;
  late TextEditingController courseController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing student data
    nameController = TextEditingController(text: widget.student.name);
    courseController = TextEditingController(text: widget.student.course);
    ageController = TextEditingController(text: widget.student.age.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Student',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.deepPurple,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Update Student Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Name Field
            _buildTextField(
              controller: nameController,
              label: 'Name',
              icon: Icons.person,
              hint: 'Enter student name',
            ),
            const SizedBox(height: 16),

            // Course Field
            _buildTextField(
              controller: courseController,
              label: 'Course',
              icon: Icons.book,
              hint: 'Enter course name',
            ),
            const SizedBox(height: 16),

            // Age Field
            _buildTextField(
              controller: ageController,
              label: 'Age',
              icon: Icons.numbers,
              hint: 'Enter age',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),

            // Student Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info, color: Colors.blue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Student ID: ${widget.student.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _updateStudent,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      'UPDATE STUDENT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    label: const Text(
                      'CANCEL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _updateStudent() {
    final name = nameController.text.trim();
    final course = courseController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (name.isEmpty || course.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields correctly!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create updated student object
    final updatedStudent = Student(
      id: widget.student.id,
      name: name,
      course: course,
      age: age,
    );

    // Return updated student to previous screen
    Navigator.pop(context, updatedStudent);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// ============ APP WIDGET ============
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