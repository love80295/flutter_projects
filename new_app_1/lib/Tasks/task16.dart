import 'package:flutter/material.dart';

class StudentInformationPortal extends StatefulWidget {
  const StudentInformationPortal({super.key});

  @override
  State<StudentInformationPortal> createState() =>
      _StudentInformationPortalState();
}

class _StudentInformationPortalState extends State<StudentInformationPortal> {
  // Student Data
  final Map<String, String> studentInfo = {
    'name': 'Love Agrawal',
    'email': 'love@gmail.com',
    'mobile': '+919359935838',
    'rollNumber': '38',
    'collegeWebsite': 'www.gla.ac.in',
  };

  // Marksheet Data
  final List<Map<String, dynamic>> marks = [
    {'subject': 'Mathematics', 'maxMarks': 100, 'obtained': 95},
    {'subject': 'Science', 'maxMarks': 100, 'obtained': 90},
    {'subject': 'English', 'maxMarks': 100, 'obtained': 88},
    {'subject': 'Computer', 'maxMarks': 100, 'obtained': 98},
    {'subject': 'Hindi', 'maxMarks': 100, 'obtained': 85},
  ];

  // Calculate totals
  int get totalMaxMarks {
    return marks.fold(0, (sum, mark) => sum + (mark['maxMarks'] as int));
  }

  int get totalObtainedMarks {
    return marks.fold(0, (sum, mark) => sum + (mark['obtained'] as int));
  }

  double get percentage {
    return (totalObtainedMarks / totalMaxMarks) * 100;
  }

  String get grade {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 50) return 'C';
    return 'D';
  }

  // Methods for actions
  void _sendEmail() {
    _showSnackBar('Opening email to: ${studentInfo['email']}');
    // You can add email functionality here without url_launcher
  }

  void _viewAddress() {
    _showSnackBar('Address: 123, College Road, New Delhi, India');
  }

  void _shareProfile() {
    _showSnackBar('Student Profile Shared Successfully!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Action Undone!'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottom Sheet Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Student Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // Action Items
              _buildBottomSheetItem(
                icon: Icons.email,
                title: 'Send Email',
                subtitle: 'Send email to student',
                color: Colors.blue,
                onTap: () {
                  Navigator.pop(context);
                  _sendEmail();
                },
              ),
              _buildBottomSheetItem(
                icon: Icons.location_on,
                title: 'View Address',
                subtitle: 'See student address',
                color: Colors.green,
                onTap: () {
                  Navigator.pop(context);
                  _viewAddress();
                },
              ),
              _buildBottomSheetItem(
                icon: Icons.share,
                title: 'Share Profile',
                subtitle: 'Share student profile',
                color: Colors.orange,
                onTap: () {
                  Navigator.pop(context);
                  _shareProfile();
                },
              ),
              _buildBottomSheetItem(
                icon: Icons.download,
                title: 'Download Marksheet',
                subtitle: 'Download marksheet PDF',
                color: Colors.deepPurple,
                onTap: () {
                  Navigator.pop(context);
                  _showSnackBar('Marksheet downloaded successfully!');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Information Portal',
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
              _showSnackBar('Student Information Portal v1.0');
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
              // 1. Student Details Card
              _buildStudentDetailsCard(),
              const SizedBox(height: 20),

              // 2. Student Actions Button
              _buildActionButton(),
              const SizedBox(height: 20),

              // 3. Student Marksheet (Table)
              _buildMarksheetTable(),
              const SizedBox(height: 20),

              // 4. Summary Card
              _buildSummaryCard(),
              const SizedBox(height: 20),

              // 5. Bottom Sheet Trigger Button
              _buildBottomSheetButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentDetailsCard() {
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
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                    size: 35,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentInfo['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Roll No: ${studentInfo['rollNumber']}',
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
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),

            // Student details using SelectableText
            _buildSelectableInfo(
              icon: Icons.email,
              label: 'Email',
              value: studentInfo['email']!,
            ),
            const SizedBox(height: 12),
            _buildSelectableInfo(
              icon: Icons.phone,
              label: 'Mobile',
              value: studentInfo['mobile']!,
            ),
            const SizedBox(height: 12),
            _buildSelectableInfo(
              icon: Icons.web,
              label: 'College Website',
              value: studentInfo['collegeWebsite']!,
              isUrl: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableInfo({
    required IconData icon,
    required String label,
    required String value,
    bool isUrl = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 12),
        SizedBox(
          width: 120,
          child: Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        if (isUrl)
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
            onPressed: () {
              _showSnackBar('Website copied to clipboard!');
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.star,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Show Student Actions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showBottomSheet,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              label: const Text('Actions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarksheetTable() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.table_chart,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Student Marksheet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.deepPurple.shade200,
                    width: 1,
                  ),
                  verticalInside: BorderSide(
                    color: Colors.deepPurple.shade200,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: Colors.deepPurple.shade200,
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: Colors.deepPurple.shade200,
                    width: 2,
                  ),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                },
                children: [
                  // Table Header
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Subject',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Max Marks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Obtained',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...marks.map((mark) {
                    return TableRow(
                      decoration: BoxDecoration(
                        color: marks.indexOf(mark).isEven
                            ? Colors.grey.shade50
                            : Colors.white,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            mark['subject'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            mark['maxMarks'].toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            mark['obtained'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: (mark['obtained'] as int) >= 80
                                  ? Colors.green
                                  : (mark['obtained'] as int) >= 60
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
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
            colors: [Colors.green.shade700, Colors.green.shade400],
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  label: 'Total Marks',
                  value: '$totalObtainedMarks/$totalMaxMarks',
                  icon: Icons.star,
                ),
                _buildSummaryItem(
                  label: 'Percentage',
                  value: '${percentage.toStringAsFixed(1)}%',
                  icon: Icons.percent,
                ),
                _buildSummaryItem(
                  label: 'Grade',
                  value: grade,
                  icon: Icons.grade,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Download Marksheet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

  Widget _buildSummaryItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _showBottomSheet,
        icon: const Icon(Icons.more_horiz),
        label: const Text(
          'Show Student Actions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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