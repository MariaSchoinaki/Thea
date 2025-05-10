import 'package:flutter/material.dart';
import 'package:thea/models/play.dart';
import 'package:thea/models/ticket.dart';
import 'package:thea/theme/app_theme.dart';

import '../widgets/pdf_file_generator.dart';

class MyTicketsScreen extends StatelessWidget {
  // Placeholder for the user's purchased tickets
  static List<Play> purchasedTickets = [
    Play(
      title: 'Be More Chill',
      imageUrl: 'assets/images/be_more_chill.jpg',
      hall: 'Stage 1',
      availableDates: {
        '2025-04-26': {'18:00': ['A32', 'A33']}
      },
      headline: '', description: '', playwriter: '', cast: [], genre: '', runtime: '', afternoon: '', night: '', regularTickets: Ticket(name: '', price: 2, availableTickets: 5, soldTickets: 2), specialNeedsTickets: Ticket(name: '', price: 4, availableTickets: 3, soldTickets: 2),  ageLimit: '23', additionalInfo: '', hearingImpaired: false,)
    // Add more purchased tickets here
  ];

  const MyTicketsScreen({Key? key}) : super(key: key);

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
              final showDate = ticket.availableDates?.keys.first ?? '';
              final showTime = ticket.availableDates?[showDate]?.keys.first ?? '';
              final seats = ticket.availableDates?[showDate]?[showTime] ?? [];
              final formattedDate = showDate.isNotEmpty ? '${DateTime.parse(showDate).day}/${DateTime.parse(showDate).month}/${DateTime.parse(showDate).year}' : '';

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
                            if (ticket.imageUrl != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: SizedBox(
                                  height: 150.0,
                                  child: Image.asset(
                                    ticket.imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.title ?? '',
                                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text('Location: ${ticket.hall ?? ''}', style: theme.textTheme.titleMedium),
                                  Text('Seats: ${seats.join(', ')}', style: theme.textTheme.titleMedium),
                                  Text('Date: $formattedDate', style: theme.textTheme.titleMedium),
                                  Text('Time: $showTime', style: theme.textTheme.titleMedium),
                                  Text('Payment up front', style: theme.textTheme.titleMedium),
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
                                //TODO: add more info to the ticket model
                                /**
                                await generateTicketPdf(
                                title: ticket.title ?? '',
                                imageUrl: ticket.imageUrl ?? 'assets/images/logo.png',
                                selectedDate: ,
                                selectedTime: selectedTime,
                                selectedSeats: selectedSeats,
                                );*/
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
                                print('Cancel Ticket for ${ticket.title}');
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
                  // TODO: Implement chatbot screen navigation
                  print('Chatbot avatar tapped');
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