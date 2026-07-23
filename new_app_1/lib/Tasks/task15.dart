import 'package:flutter/material.dart';

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() =>
      _StudentRegistrationFormState();
}

class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;

  // TextEditingControllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  // Student data to display after submission
  Map<String, String>? _studentData;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _rollController.dispose();
    _courseController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    final mobileRegex = RegExp(r'^[0-9]{10}$');
    if (!mobileRegex.hasMatch(value)) {
      return 'Please enter a valid 10 digit mobile number';
    }
    return null;
  }

  String? validateRollNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your roll number';
    }
    if (value.length < 2) {
      return 'Please enter a valid roll number';
    }
    return null;
  }

  String? validateCourse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your course';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If all validations pass, save the data
      setState(() {
        _studentData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'mobile': _mobileController.text,
          'roll': _rollController.text,
          'course': _courseController.text,
          'city': _cityController.text,
        };
        _isSubmitted = true;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student Registered Successfully! 🎉'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _rollController.clear();
      _courseController.clear();
      _cityController.clear();
      _studentData = null;
      _isSubmitted = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form has been reset'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Registration',
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
        child: SingleChildScrollView(
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
                child: Row(
                  children: [
                    Icon(
                      _isSubmitted ? Icons.check_circle : Icons.school,
                      color: _isSubmitted ? Colors.green : Colors.deepPurple,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _isSubmitted
                            ? 'Student Registered Successfully!'
                            : 'Please fill in the details to register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _isSubmitted ? Colors.green : Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Show success message if form is submitted
              if (_isSubmitted && _studentData != null)
                _buildSuccessCard()
              else
                _buildRegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Full Name',
            hint: 'Please enter your full name',
            icon: Icons.person,
            validator: validateName,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'Please enter your email address',
            icon: Icons.email,
            validator: validateEmail,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _mobileController,
            label: 'Mobile Number',
            hint: 'Please enter 10 digit mobile number',
            icon: Icons.phone,
            validator: validateMobile,
            isRequired: true,
            keyboardType: TextInputType.phone,
            maxLength: 10,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _rollController,
            label: 'Roll Number',
            hint: 'Please enter your roll number',
            icon: Icons.numbers,
            validator: validateRollNumber,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _courseController,
            label: 'Course',
            hint: 'Please enter your course',
            icon: Icons.book,
            validator: validateCourse,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _cityController,
            label: 'City',
            hint: 'Please enter your city',
            icon: Icons.location_city,
            validator: validateCity,
            isRequired: true,
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    bool isRequired = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
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
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
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
          errorStyle: const TextStyle(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Icon
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Student Registered Successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Display student details
            _buildDetailRow('Name', _studentData?['name'] ?? ''),
            const SizedBox(height: 8),
            _buildDetailRow('Email', _studentData?['email'] ?? ''),
            const SizedBox(height: 8),
            _buildDetailRow('Mobile', _studentData?['mobile'] ?? ''),
            const SizedBox(height: 8),
            _buildDetailRow('Roll No', _studentData?['roll'] ?? ''),
            const SizedBox(height: 8),
            _buildDetailRow('Course', _studentData?['course'] ?? ''),
            const SizedBox(height: 8),
            _buildDetailRow('City', _studentData?['city'] ?? ''),

            const SizedBox(height: 24),

            // OK Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSubmitted = false;
                    _resetForm();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label :',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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