import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ============ MAIN APP ============
class StudentAssignmentPortal extends StatefulWidget {
  const StudentAssignmentPortal({super.key});

  @override
  State<StudentAssignmentPortal> createState() =>
      _StudentAssignmentPortalState();
}

class _StudentAssignmentPortalState extends State<StudentAssignmentPortal> {
  // Assignment Details
  final Map<String, dynamic> assignmentDetails = {
    'title': 'Flutter UI Widgets',
    'subject': 'Mobile Application Dev.',
    'faculty': 'Mr. Pankaj Kapoor',
    'lastDate': '30 July 2026',
    'totalMarks': 100,
  };

  // Student Data
  final Map<String, dynamic> studentData = {
    'name': 'Love Agrawal',
    'assignment': 'Flutter UI Widgets',
    'submissionDate': '28 July 2026',
    'submissionTime': '03:30 PM',
    'uploadedFile': 'assignment_flutter.pdf',
  };

  // State variables
  bool isSubmitted = false;
  bool isRatingSubmitted = false;
  double rating = 4.5;
  TimeOfDay selectedTime = const TimeOfDay(hour: 15, minute: 30);
  DateTime selectedDate = DateTime(2026, 7, 28);
  double uploadProgress = 65.0;
  bool isUploading = false;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _assignmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = studentData['name']!;
    _assignmentController.text = studentData['assignment']!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _assignmentController.dispose();
    super.dispose();
  }

  // Navigation methods
  void _showSubmitDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit Assignment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _assignmentController,
                decoration: const InputDecoration(
                  labelText: 'Assignment Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  _pickFile();
                },
                icon: const Icon(Icons.attach_file),
                label: const Text('Choose File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              if (isUploading) _buildUploadProgress(),
            ],
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
                setState(() {
                  isSubmitted = true;
                  isUploading = true;
                });
                _simulateUpload();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _simulateUpload() {
    // Simulate file upload progress
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        uploadProgress = 85.0;
      });
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        uploadProgress = 100.0;
        isUploading = false;
      });
      // Show success dialog after upload
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    Navigator.pop(context); // Close submit dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Submission Successful'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assignment Submitted Successfully!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              _buildDetailRow('Student Name', studentData['name']!),
              _buildDetailRow('Assignment', studentData['assignment']!),
              _buildDetailRow('Submission Date', studentData['submissionDate']!),
              _buildDetailRow('Submission Time', studentData['submissionTime']!),
              _buildDetailRow('Uploaded File', studentData['uploadedFile']!),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showRatingDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Text(
                '${rating.toStringAsFixed(1)} / 5',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              if (isRatingSubmitted)
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Thank you for your feedback!',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            if (!isRatingSubmitted)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isRatingSubmitted = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rating submitted successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Submit Rating'),
              ),
            if (isRatingSubmitted)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
          ],
        );
      },
    );
  }

  void _pickFile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File selected: assignment_flutter.pdf'),
        backgroundColor: Colors.blue,
      ),
    );
    setState(() {
      studentData['uploadedFile'] = 'assignment_flutter.pdf';
    });
  }

  void _showGuidelines() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assignment Guidelines'),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📋 Assignment Instructions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('1. Submit your assignment in PDF format'),
                const Text('2. File size should be less than 10MB'),
                const Text('3. Include your name and roll number'),
                const Text('4. Follow the proper formatting guidelines'),
                const Text('5. Submit before the deadline'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📅 Important Dates:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('• Last Date: 30 July 2026'),
                      Text('• Review Date: 5 August 2026'),
                      Text('• Result Date: 15 August 2026'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '📝 Note: Late submissions will be penalized',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showDocumentation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('View Flutter Docs'),
            ),
          ],
        );
      },
    );
  }

  void _showDocumentation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Flutter Documentation'),
          content: const SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📚 Flutter UI Widgets Documentation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                Text('• Flutter is Google\'s UI toolkit'),
                Text('• Build natively compiled applications'),
                Text('• Single codebase for mobile, web, desktop'),
                Text('• Hot reload for faster development'),
                Text('• Rich set of pre-built widgets'),
                Text('• Material Design and Cupertino support'),
                SizedBox(height: 12),
                Text(
                  '🔗 Official Documentation:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('https://flutter.dev/docs'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening Flutter Documentation...'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Open Docs'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProgress() {
    return Column(
      children: [
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: uploadProgress / 100,
          backgroundColor: Colors.grey.shade200,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(
          'Uploading... ${uploadProgress.toStringAsFixed(0)}%',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Assignment Portal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showTooltip();
            },
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
              // Assignment Details Card
              _buildAssignmentCard(),
              const SizedBox(height: 16),

              // Action Buttons
              _buildActionButtons(),
              const SizedBox(height: 16),

              // Time Picker Section
              _buildTimePickerSection(),
              const SizedBox(height: 16),

              // Tooltip Demo
              _buildTooltipDemo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard() {
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
                  Icons.assignment,
                  color: Colors.white,
                  size: 28,
                ),
                SizedBox(width: 12),
                Text(
                  'Assignment Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.title,
              'Assignment',
              assignmentDetails['title']!,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.book,
              'Subject',
              assignmentDetails['subject']!,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.person,
              'Faculty',
              assignmentDetails['faculty']!,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.calendar_today,
              'Last Date',
              assignmentDetails['lastDate']!,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.star,
              'Total Marks',
              assignmentDetails['totalMarks'].toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(width: 12),
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _showSubmitDialog,
            icon: const Icon(Icons.cloud_upload, color: Colors.white),
            label: const Text(
              'Submit Assignment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
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
            onPressed: _showGuidelines,
            icon: const Icon(Icons.description, color: Colors.white),
            label: const Text(
              'View Guidelines',
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
      ],
    );
  }

  Widget _buildTimePickerSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.access_time, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'Time Picker',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeButton(
                  label: 'Pick Date',
                  icon: Icons.calendar_today,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2027),
                    );
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                        studentData['submissionDate'] =
                            '${date.day} ${_getMonthName(date.month)} ${date.year}';
                      });
                    }
                  },
                ),
                _buildTimeButton(
                  label: 'Pick Time',
                  icon: Icons.timer,
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                        final hour = time.hour > 12 ? time.hour - 12 : time.hour;
                        final minute = time.minute.toString().padLeft(2, '0');
                        final ampm = time.hour >= 12 ? 'PM' : 'AM';
                        studentData['submissionTime'] = '$hour:$minute $ampm';
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Selected Date',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        studentData['submissionDate']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey.shade300,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Selected Time',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        studentData['submissionTime']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildTooltipDemo() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'Tooltip Demo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Tooltip(
                  message: 'Submit your assignment',
                  child: ElevatedButton.icon(
                    onPressed: _showSubmitDialog,
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'View assignment guidelines',
                  child: ElevatedButton.icon(
                    onPressed: _showGuidelines,
                    icon: const Icon(Icons.description),
                    label: const Text('Guidelines'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Rate your experience',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        isRatingSubmitted = false;
                      });
                      _showRatingDialog();
                    },
                    icon: const Icon(Icons.star),
                    label: const Text('Rate'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'View Flutter documentation',
                  child: IconButton(
                    onPressed: _showDocumentation,
                    icon: const Icon(Icons.book, color: Colors.deepPurple),
                    tooltip: 'Documentation',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.amber),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hover or long-press on buttons to see tooltips',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTooltip() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student Assignment Portal v1.0'),
        backgroundColor: Colors.deepPurple,
        duration: Duration(seconds: 2),
      ),
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