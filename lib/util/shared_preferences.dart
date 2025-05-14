import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/bought_ticket.dart';

Future<void> saveBoughtTickets(List<BoughtTicket> tickets) async {
  final prefs = await SharedPreferences.getInstance();
  final ticketList = tickets.map((t) => jsonEncode(t.toJson())).toList();
  await prefs.setStringList('bought_tickets', ticketList);
}

Future<List<BoughtTicket>> loadBoughtTickets() async {
  final prefs = await SharedPreferences.getInstance();
  final ticketJsonList = prefs.getStringList('bought_tickets') ?? [];

  return ticketJsonList.map((t) {
    final decoded = jsonDecode(t);
    return BoughtTicket.fromJson(decoded);
  }).toList();
}

Future<void> addBoughtTicket(BoughtTicket newTicket) async {
  List<BoughtTicket> current = await loadBoughtTickets();
  current.add(newTicket);
  await saveBoughtTickets(current);
}
