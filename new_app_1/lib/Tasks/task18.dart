import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentPlacementRegistration extends StatefulWidget {
  const StudentPlacementRegistration({super.key});

  @override
  State<StudentPlacementRegistration> createState() =>
      _StudentPlacementRegistrationState();
}

class _StudentPlacementRegistrationState
    extends State<StudentPlacementRegistration> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();

  // Dropdown values
  String selectedBranch = 'Computer Science';
  String selectedPlacementStatus = 'Not Placed';
  String selectedInterest = 'Yes';

  // Available options
  final List<String> branches = [
    'Computer Science',
    'Information Technology',
    'Electronics & Communication',
    'Mechanical Engineering',
    'Civil Engineering',
    'Electrical Engineering',
    'Chemical Engineering',
  ];

  final List<String> placementStatus = [
    'Not Placed',
    'Placed',
    'Internship',
    'Higher Studies',
  ];

  final List<String> interestOptions = ['Yes', 'No'];

  // View mode
  bool isViewMode = false;
  bool isEditMode = false;

  // Student data
  Map<String, dynamic> studentData = {};

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  // Load data from SharedPreferences
  Future<void> _loadStudentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        studentData = {
          'name': prefs.getString('student_name') ?? '',
          'rollNumber': prefs.getString('student_roll') ?? '',
          'email': prefs.getString('student_email') ?? '',
          'mobile': prefs.getString('student_mobile') ?? '',
          'branch': prefs.getString('student_branch') ?? 'Computer Science',
          'cgpa': prefs.getDouble('student_cgpa') ?? 0.0,
          'placementStatus':
              prefs.getString('student_placement_status') ?? 'Not Placed',
          'interest': prefs.getString('student_interest') ?? 'Yes',
        };

        // Update controllers with loaded data
        _nameController.text = studentData['name'] ?? '';
        _rollController.text = studentData['rollNumber'] ?? '';
        _emailController.text = studentData['email'] ?? '';
        _mobileController.text = studentData['mobile'] ?? '';
        _cgpaController.text = studentData['cgpa'] != 0.0
            ? studentData['cgpa'].toString()
            : '';
        selectedBranch = studentData['branch'] ?? 'Computer Science';
        selectedPlacementStatus = studentData['placementStatus'] ?? 'Not Placed';
        selectedInterest = studentData['interest'] ?? 'Yes';

        // Check if data exists to show view mode
        if (studentData['name'] != null && studentData['name']!.isNotEmpty) {
          isViewMode = true;
        }
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  // Save data to SharedPreferences
  Future<void> _saveStudentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('student_name', _nameController.text.trim());
      await prefs.setString('student_roll', _rollController.text.trim());
      await prefs.setString('student_email', _emailController.text.trim());
      await prefs.setString('student_mobile', _mobileController.text.trim());
      await prefs.setString('student_branch', selectedBranch);
      await prefs.setDouble(
          'student_cgpa', double.parse(_cgpaController.text.trim()));
      await prefs.setString('student_placement_status', selectedPlacementStatus);
      await prefs.setString('student_interest', selectedInterest);

      setState(() {
        isViewMode = true;
        isEditMode = false;
        studentData = {
          'name': _nameController.text.trim(),
          'rollNumber': _rollController.text.trim(),
          'email': _emailController.text.trim(),
          'mobile': _mobileController.text.trim(),
          'branch': selectedBranch,
          'cgpa': double.parse(_cgpaController.text.trim()),
          'placementStatus': selectedPlacementStatus,
          'interest': selectedInterest,
        };
      });

      _showSnackBar('Registration Saved Successfully!', Colors.green);
    } catch (e) {
      _showSnackBar('Error saving data: $e', Colors.red);
    }
  }

  // Clear data from SharedPreferences
  Future<void> _clearStudentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      setState(() {
        _nameController.clear();
        _rollController.clear();
        _emailController.clear();
        _mobileController.clear();
        _cgpaController.clear();
        selectedBranch = 'Computer Science';
        selectedPlacementStatus = 'Not Placed';
        selectedInterest = 'Yes';
        isViewMode = false;
        isEditMode = false;
        studentData = {};
      });

      _showSnackBar('Form Cleared Successfully!', Colors.orange);
    } catch (e) {
      _showSnackBar('Error clearing data: $e', Colors.red);
    }
  }

  // Delete student data
  Future<void> _deleteStudentData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      setState(() {
        _nameController.clear();
        _rollController.clear();
        _emailController.clear();
        _mobileController.clear();
        _cgpaController.clear();
        selectedBranch = 'Computer Science';
        selectedPlacementStatus = 'Not Placed';
        selectedInterest = 'Yes';
        isViewMode = false;
        isEditMode = false;
        studentData = {};
      });

      _showSnackBar('Student Details Deleted Successfully!', Colors.red);
    } catch (e) {
      _showSnackBar('Error deleting data: $e', Colors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _validateAndSave() {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Please enter Student Name', Colors.red);
      return;
    }
    if (_rollController.text.trim().isEmpty) {
      _showSnackBar('Please enter Roll Number', Colors.red);
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      _showSnackBar('Please enter Email', Colors.red);
      return;
    }
    if (_mobileController.text.trim().isEmpty) {
      _showSnackBar('Please enter Mobile Number', Colors.red);
      return;
    }
    if (_cgpaController.text.trim().isEmpty) {
      _showSnackBar('Please enter CGPA', Colors.red);
      return;
    }

    final cgpa = double.tryParse(_cgpaController.text.trim());
    if (cgpa == null || cgpa < 0 || cgpa > 10) {
      _showSnackBar('Please enter a valid CGPA (0-10)', Colors.red);
      return;
    }

    _saveStudentData();
  }

  // Navigation methods
  void _showEditForm() {
    setState(() {
      isEditMode = true;
      isViewMode = false;
    });
  }

  void _showViewMode() {
    setState(() {
      isViewMode = true;
      isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isViewMode && !isEditMode
              ? 'Placement Dashboard'
              : 'Student Placement Registration',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (isViewMode && !isEditMode)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _showEditForm,
              tooltip: 'Edit Details',
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Registration Form (Show when not in view mode or in edit mode)
              if (!isViewMode || isEditMode) ...[
                _buildRegistrationForm(),
                const SizedBox(height: 16),
                _buildActionButtons(),
              ],

              // Dashboard View (Show when in view mode and not in edit mode)
              if (isViewMode && !isEditMode) ...[
                _buildDashboard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Register Your Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Form Fields
            _buildFormField(
              controller: _nameController,
              label: 'Student Name',
              icon: Icons.person,
              hint: 'Enter student name',
            ),
            const SizedBox(height: 12),
            _buildFormField(
              controller: _rollController,
              label: 'Roll Number',
              icon: Icons.numbers,
              hint: 'Enter roll number',
            ),
            const SizedBox(height: 12),
            _buildFormField(
              controller: _emailController,
              label: 'Email',
              icon: Icons.email,
              hint: 'Enter email address',
            ),
            const SizedBox(height: 12),
            _buildFormField(
              controller: _mobileController,
              label: 'Mobile Number',
              icon: Icons.phone,
              hint: 'Enter mobile number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _buildDropdownField(
              value: selectedBranch,
              items: branches,
              label: 'Branch',
              icon: Icons.school,
              onChanged: (value) {
                setState(() {
                  selectedBranch = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildFormField(
              controller: _cgpaController,
              label: 'CGPA',
              icon: Icons.grade,
              hint: 'Enter CGPA (0-10)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            _buildDropdownField(
              value: selectedPlacementStatus,
              items: placementStatus,
              label: 'Placement Status',
              icon: Icons.work,
              onChanged: (value) {
                setState(() {
                  selectedPlacementStatus = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildDropdownField(
              value: selectedInterest,
              items: interestOptions,
              label: 'Interested',
              icon: Icons.star,
              onChanged: (value) {
                setState(() {
                  selectedInterest = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
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

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required String label,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Colors.white,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _validateAndSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'SAVE DETAILS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _clearStudentData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'CLEAR FORM',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboard() {
    return Column(
      children: [
        // Welcome Card
        Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text(
                        studentData['name']?.isNotEmpty == true
                            ? studentData['name'][0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${studentData['name'] ?? 'Student'}!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your placement details are saved.',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Details Card
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.info, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text(
                      'Student Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Student Name', studentData['name'] ?? ''),
                const Divider(),
                _buildDetailRow('Roll Number', studentData['rollNumber'] ?? ''),
                const Divider(),
                _buildDetailRow('Email', studentData['email'] ?? ''),
                const Divider(),
                _buildDetailRow('Mobile Number', studentData['mobile'] ?? ''),
                const Divider(),
                _buildDetailRow('Branch', studentData['branch'] ?? ''),
                const Divider(),
                _buildDetailRow(
                    'CGPA', (studentData['cgpa'] ?? 0.0).toString()),
                const Divider(),
                _buildDetailRow(
                    'Placement Status', studentData['placementStatus'] ?? ''),
                const Divider(),
                _buildDetailRow('Interested', studentData['interest'] ?? ''),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _showEditForm,
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'EDIT DETAILS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
                  _showDeleteConfirmation();
                },
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text(
                  'DELETE DETAILS',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Details'),
          content: const Text(
            'Are you sure you want to delete all student details? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteStudentData();
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
}

// ============ MAIN ENTRY POINT ============
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Placement Registration',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const StudentPlacementRegistration(),
      debugShowCheckedModeBanner: false,
    );
  }
}