import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thea/theme/app_theme.dart';

import '../widgets/bottom_navigation_bar.dart';

import '../models/complaint.dart';


class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _saveComplaint(Complaint complaint) async {
    final prefs = await SharedPreferences.getInstance();
    final String? complaintsJson = prefs.getString('complaints_list');
    List<dynamic> complaintsList = [];

    if (complaintsJson != null) {
      complaintsList = jsonDecode(complaintsJson);
    }

    complaintsList.add(complaint.toJson());

    await prefs.setString('complaints_list', jsonEncode(complaintsList));
  }

  String? _validateNotEmpty(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $label.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number.';
    }
    final regex = RegExp(r'^\d{10,15}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  InputDecoration buildInputDecoration(String label) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InputDecoration(
      label: RichText(
        text: TextSpan(
          text: '$label ',
          style: TextStyle(color: isDark ? Colors.black87 : Colors.white70),
          children: const [
            TextSpan(
              text: '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      border: const OutlineInputBorder(),
    );
  }

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final complaint = Complaint(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
        subject: _subjectController.text.trim(),
        description: _descriptionController.text.trim(), timestamp: DateTime.now(),
      );

      await _saveComplaint(complaint);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint submitted successfully!')),
      );

      _formKey.currentState?.reset();
      _firstNameController.clear();
      _lastNameController.clear();
      _phoneController.clear();
      _subjectController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title:  Text('Make a Complaint', style: TextStyle(color: isDark? Colors.grey[300] : Colors.black87)),
        backgroundColor: isDark? AppColorsDark.background : AppColors.background,
        iconTheme: IconThemeData(color: isDark? Colors.grey[300] : Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Please fill out the form below to submit your complaint.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _firstNameController,
                decoration: buildInputDecoration('First Name'),
                validator: (value) => _validateNotEmpty(value, 'first name'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _lastNameController,
                decoration: buildInputDecoration('Last Name'),
                validator: (value) => _validateNotEmpty(value, 'last name'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: buildInputDecoration('Phone Number'),
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _subjectController,
                decoration: buildInputDecoration('Subject'),
                validator: (value) => _validateNotEmpty(value, 'subject'),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: buildInputDecoration('Description'),
                validator: (value) => _validateNotEmpty(value, 'description'),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark? AppColorsDark.coral : AppColors.coral,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  child: const Text('Submit Complaint', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: MyNavBar(currentIndex: 0)
    );
  }
}
