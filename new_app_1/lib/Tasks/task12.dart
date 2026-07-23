import 'package:flutter/material.dart';

class UserPreferencesScreen extends StatefulWidget {
  const UserPreferencesScreen({super.key});

  @override
  State<UserPreferencesScreen> createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  // State variables
  bool notificationsEnabled = true;
  bool isDarkMode = true;
  String selectedGender = 'Female';
  bool termsAccepted = true;
  double fontSize = 20.0;
  String selectedInterest = 'AI';
  int currentStep = 2; // Profile completion step
  bool isSaved = false;

  // Gender options
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  
  // Interest options
  final List<String> interestOptions = [
    'Flutter',
    'AI',
    'Web Development',
    'Game Development'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Preferences',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Enable Notifications - Switch
              _buildSectionCard(
                title: 'Enable Notifications',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          notificationsEnabled ? 'Enabled' : 'Disabled',
                          style: TextStyle(
                            color: notificationsEnabled ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              notificationsEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 2. Choose Theme - Radio
              _buildSectionCard(
                title: 'Choose Theme',
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: const Text('Light'),
                            leading: Radio<String>(
                              value: 'Light',
                              groupValue: isDarkMode ? 'Dark' : 'Light',
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = false;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text('Dark'),
                            leading: Radio<String>(
                              value: 'Dark',
                              groupValue: isDarkMode ? 'Dark' : 'Light',
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = true;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selected Mode: ${isDarkMode ? 'Dark' : 'Light'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 3. Select Gender - Choice Chips
              _buildSectionCard(
                title: 'Select Gender',
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: genderOptions.map((gender) {
                        return ChoiceChip(
                          label: Text(gender),
                          selected: selectedGender == gender,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedGender = gender;
                              }
                            });
                          },
                          selectedColor: Colors.blue,
                          backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                          labelStyle: TextStyle(
                            color: selectedGender == gender 
                                ? Colors.white 
                                : (isDarkMode ? Colors.white : Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selected Gender: $selectedGender',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 4. Terms & Conditions - Checkbox (FIXED)
              _buildSectionCard(
                title: 'Terms & Conditions',
                child: Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value!;
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                    Expanded(
                      child: const Text(
                        'I accept the Terms & Conditions',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      'Status: ${termsAccepted ? 'Accepted' : 'Not Accepted'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: termsAccepted ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 5. Font Size - Slider
              _buildSectionCard(
                title: 'Font Size (Sample Text)',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('10'),
                        Expanded(
                          child: Slider(
                            value: fontSize,
                            min: 10,
                            max: 30,
                            divisions: 20,
                            onChanged: (value) {
                              setState(() {
                                fontSize = value;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                        ),
                        const Text('30'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current Size: ${fontSize.round()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Flutter is Awesome!',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 6. Choose Interests - Choice Chips
              _buildSectionCard(
                title: 'Choose Your Interests (Select One)',
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: interestOptions.map((interest) {
                        return ChoiceChip(
                          label: Text(interest),
                          selected: selectedInterest == interest,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedInterest = interest;
                              }
                            });
                          },
                          selectedColor: Colors.blue,
                          backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[200],
                          labelStyle: TextStyle(
                            color: selectedInterest == interest 
                                ? Colors.white 
                                : (isDarkMode ? Colors.white : Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Selected Interest: $selectedInterest',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 7. Quick Actions - Action Chips
              _buildSectionCard(
                title: 'Quick Actions',
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        ActionChip(
                          label: const Text('Reset'),
                          onPressed: () {
                            setState(() {
                              _resetPreferences();
                            });
                          },
                          backgroundColor: Colors.red,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                        ActionChip(
                          label: const Text('Save'),
                          onPressed: () {
                            setState(() {
                              isSaved = true;
                              _showSnackBar('Preferences Saved Successfully!');
                            });
                          },
                          backgroundColor: Colors.green,
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (isSaved)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Preferences Saved Successfully!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSaved = false;
                                });
                              },
                              child: const Text('DISMISS'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // 8. Profile Completion - Stepper
              _buildSectionCard(
                title: 'Profile Completion',
                child: Column(
                  children: [
                    // Simple step indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStepIndicator(0, 'Personal Details', currentStep),
                        _buildStepConnector(currentStep > 0),
                        _buildStepIndicator(1, 'Preferences', currentStep),
                        _buildStepConnector(currentStep > 1),
                        _buildStepIndicator(2, 'Finish', currentStep),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: currentStep > 0 
                              ? () {
                                  setState(() {
                                    currentStep--;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text('CANCEL'),
                        ),
                        ElevatedButton(
                          onPressed: currentStep < 2 
                              ? () {
                                  setState(() {
                                    currentStep++;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(currentStep == 2 ? 'FINISH' : 'CONTINUE'),
                        ),
                      ],
                    ),
                  ],
                ),
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section cards
  Widget _buildSectionCard({
    required String title,
    required Widget child,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 4,
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }

  // Helper method to build step indicators
  Widget _buildStepIndicator(int step, String label, int currentStep) {
    bool isActive = step <= currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Text(
            '${step + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.blue : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.blue : Colors.grey,
        margin: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  // Reset all preferences
  void _resetPreferences() {
    setState(() {
      notificationsEnabled = true;
      isDarkMode = true;
      selectedGender = 'Female';
      termsAccepted = true;
      fontSize = 20.0;
      selectedInterest = 'AI';
      currentStep = 2;
      isSaved = false;
    });
    _showSnackBar('Preferences Reset!');
  }

  // Show snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}