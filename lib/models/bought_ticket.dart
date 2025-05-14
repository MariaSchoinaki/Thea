import 'package:thea/models/play.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:intl/intl.dart';


class BoughtTicket {
  final String id;
  final Play play;
  final DateTime date;
  final String time;
  final List<String> seats;
  final double totalPrice;
  final bool isPaid;
  final uuid = Uuid();

  BoughtTicket({
    String? id, // optional
    required this.play,
    required this.date,
    required this.time,
    required this.seats,
    required this.totalPrice,
    this.isPaid = false,
  }) : id = id ?? generateTicketId(date, seats);

  Map<String, dynamic> toJson() => {
    'id': id,
    'play': play.toJson(),
    'date': date.toIso8601String(),
    'time': time,
    'seats': seats,
    'totalPrice': totalPrice,
    'isPaid': isPaid,
  };

  factory BoughtTicket.fromJson(Map<String, dynamic> json) => BoughtTicket(

    id: json['id'] ?? generateTicketId(DateTime.parse(json['date'] as String), (json['seats'] as List<dynamic>).cast<String>()),
    play: Play.fromJson(json['play']),
    date: DateTime.parse(json['date']),
    time: json['time'],
    seats: List<String>.from(json['seats']),
    totalPrice: (json['totalPrice'] as num).toDouble(),
    isPaid: json['isPaid'] ?? false,
  );
}


String generateTicketId(DateTime date, List<String> seats) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random.secure();
  final randomPart = List.generate(6, (_) => chars[rand.nextInt(chars.length)]).join();

  final formattedDate = DateFormat('yyyyMMdd').format(date);
  final seatPart = seats.join('');

  return 'TKT-$formattedDate-$seatPart-$randomPart';
}
