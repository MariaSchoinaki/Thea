import 'package:flutter/material.dart';
import 'package:thea/theme/app_theme.dart';

import '../widgets/bottom_navigation_bar.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Please fill out the form below to submit your complaint.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the subject of your complaint.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description of your complaint.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement complaint submission logic
                      final String subject = _subjectController.text;
                      final String description = _descriptionController.text;
                      print('Complaint submitted:\nSubject: $subject\nDescription: $description');
                      // You would typically send this data to your server or handle it locally.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Complaint submitted successfully!')),
                      );
                      _subjectController.clear();
                      _descriptionController.clear();
                    }
                  },
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