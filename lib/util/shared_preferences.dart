import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/bought_ticket.dart';
import '../models/complaint.dart';

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

Future<void> cancelTicket(String ticketId) async {
  // Load the current list of bought tickets
  List<BoughtTicket> currentTickets = await loadBoughtTickets();

  // Remove the ticket with the provided ticketId
  currentTickets.removeWhere((ticket) => ticket.id == ticketId);

  // Save the updated list back to SharedPreferences
  await saveBoughtTickets(currentTickets);
}

const _key = 'complaints';

Future<void> saveComplaint(Complaint complaint) async {
  final prefs = await SharedPreferences.getInstance();
  final existing = prefs.getStringList(_key) ?? [];

  final newList = [...existing, jsonEncode(complaint.toJson())];
  await prefs.setStringList(_key, newList);
}

Future<List<Complaint>> loadComplaints() async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList(_key) ?? [];

  return list.map((e) => Complaint.fromJson(jsonDecode(e))).toList();
}

Future<void> clearComplaints() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_key);
}
