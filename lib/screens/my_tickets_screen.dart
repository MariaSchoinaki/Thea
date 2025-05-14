import 'package:flutter/material.dart';
import 'package:thea/models/booking_stage.dart';
import 'package:thea/models/play.dart';
import 'package:thea/models/ticket.dart';
import 'package:thea/theme/app_theme.dart';

import '../models/bought_ticket.dart';
import '../util/shared_preferences.dart';
import '../widgets/pdf_file_generator.dart';

class MyTicketsScreen extends StatefulWidget {

  const MyTicketsScreen({Key? key}) : super(key: key);
  @override
  State<MyTicketsScreen> createState() => _MyTicketsScreenState();

}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  List<BoughtTicket> purchasedTickets = [];

  @override
  void initState() {
    super.initState();
    loadBoughtTickets().then((tickets) {
      setState(() {
        purchasedTickets = tickets;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My tickets', style: TextStyle(color: Colors.black87)),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: purchasedTickets.length,
            itemBuilder: (context, index) {
              final ticket = purchasedTickets[index];
              final showDate = ticket.date;
              final showTime = ticket.time;
              final seats = ticket.seats;
              final formattedDate = '${showDate.day}/${showDate.month}/${showDate.year}';

              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                color: AppColors.container,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                    Column(
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
                                backgroundColor: AppColors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              child: const Text('Download Ticket'),
                              ),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Implement cancel ticket functionality for this ticket
                                print('Cancel Ticket for ${ticket.play.title}');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                              ),
                              child: const Text('Cancel Ticket'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: AppColors.container,
        unselectedItemColor: AppColors.darkText,
        backgroundColor: AppColors.background,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home_page');
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyTicketsScreen(),
                ),
              );
              break;
            case 2:
            // Navigator.pushNamed(context, '/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'My tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_accessibility),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}