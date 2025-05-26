import 'dart:convert';

class Complaint {
  final String firstName;
  final String lastName;
  final String phone;
  final String subject;
  final String description;
  final DateTime timestamp;

  Complaint({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.subject,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'subject': subject,
    'description': description,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    firstName: json['firstName'],
    lastName: json['lastName'],
    phone: json['phone'],
    subject: json['subject'],
    description: json['description'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
