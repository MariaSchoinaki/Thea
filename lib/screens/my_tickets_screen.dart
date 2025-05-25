import 'package:flutter/material.dart';
import 'package:thea/models/booking_stage.dart';
import 'package:thea/models/play.dart';
import 'package:thea/models/ticket.dart';
import 'package:thea/screens/preferences_screen.dart';
import 'package:thea/theme/app_theme.dart';

import '../models/bought_ticket.dart';
import '../util/shared_preferences.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/pdf_file_generator.dart';

class MyTicketsScreen extends StatefulWidget {

  const MyTicketsScreen({Key? key}) : super(key: key);
  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();

}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  List<BoughtTicket> purchasedTickets = [];
  Set<String> visibleTicketIds = {}; // π.χ. based on ticket.id (create one if needed)

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    List<BoughtTicket> tickets = await loadBoughtTickets();
    setState(() {
      purchasedTickets = tickets;
      visibleTicketIds = purchasedTickets.map((t) => t.id).toSet();
    });
  }

  Widget buildTicketCard(BoughtTicket ticket, int index, BuildContext context) {
    final theme = Theme.of(context);
    final showDate = ticket.date;
    final showTime = ticket.time;
    final seats = ticket.seats;
    final formattedDate = showDate;
    final ticketId = ticket.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SizedBox(
                    height: 150.0,
                    child: Image.asset(
                      ticket.play.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.play.title,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Location: ${ticket.play.hall}', style: theme.textTheme.titleMedium),
                      Text('Seats: ${seats.join(', ')}', style: theme.textTheme.titleMedium),
                      Text('Date: $formattedDate', style: theme.textTheme.titleMedium),
                      Text('Time: $showTime', style: theme.textTheme.titleMedium),
                      Text(ticket.isPaid ? 'Already Paid' : 'Payment up front', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await generateTicketPdf(
                      title: ticket.play.title ?? '',
                      imageUrl: ticket.play.imageUrl ?? 'assets/images/logo.png',
                      selectedDate: showDate,
                      selectedTime: showTime,
                      selectedSeats: seats,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.tertiary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Download Ticket'),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Custom fade+remove
                    setState(() {
                      visibleTicketIds.remove(ticketId);
                    });

                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {
                        purchasedTickets.removeAt(index);
                        saveBoughtTickets(purchasedTickets); // αν το κάνεις
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.tertiaryContainer,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Cancel Ticket'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('My tickets'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: IconThemeData(color: isDark? Colors.grey[300] : Colors.black87),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: purchasedTickets.length,
            itemBuilder: (context, index) {
              final ticket = purchasedTickets[index];
              final ticketId = ticket.id;
              final showDate = ticket.date;
              final showTime = ticket.time;
              final seats = ticket.seats;
              final formattedDate = '${showDate.day}/${showDate.month}/${showDate.year}';

              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: visibleTicketIds.contains(ticketId) ? 1.0 : 0.0,
                  child: visibleTicketIds.contains(ticketId)
                      ? buildTicketCard(ticket, index, context)
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  navigate(context, BookingStage.initial);
                },
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/bot_avatar.png'),
                ),
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: MyNavBar(currentIndex: 1)
    );
  }

  void _cancelTicket(BoughtTicket ticket) {
    setState(() {
      purchasedTickets.remove(ticket);// Update UI after cancellation
      cancelTicket(ticket.id);
    });
  }
}