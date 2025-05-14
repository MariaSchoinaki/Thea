import 'package:thea/models/play.dart';

class BoughtTicket {
  final Play play;
  final DateTime date;
  final String time;
  final List<String> seats;
  final double totalPrice;
  final bool isPaid;

  BoughtTicket({
    required this.play,
    required this.date,
    required this.time,
    required this.seats,
    required this.totalPrice,
    this.isPaid = false,
  });

  Map<String, dynamic> toJson() => {
    'play': play.toJson(),
    'date': date.toIso8601String(),
    'time': time,
    'seats': seats,
    'totalPrice': totalPrice,
    'isPaid': isPaid,
  };

  factory BoughtTicket.fromJson(Map<String, dynamic> json) => BoughtTicket(
    play: Play.fromJson(json['play']),
    date: DateTime.parse(json['date']),
    time: json['time'],
    seats: List<String>.from(json['seats']),
    totalPrice: (json['totalPrice'] as num).toDouble(),
    isPaid: json['isPaid'] ?? false,
  );
}
