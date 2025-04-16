import 'base_model.dart';

class Ticket implements BaseModel {
  final String name;
  final double price;
  final int availableTickets;
  final int soldTickets;

  Ticket({
    required this.name,
    required this.price,
    required this.availableTickets,
    required this.soldTickets,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      availableTickets: json['availableTickets'] as int,
      soldTickets: json['soldTickets'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'availableTickets': availableTickets,
      'soldTickets': soldTickets,
    };
  }
}
