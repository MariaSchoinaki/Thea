import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thea/models/bought_ticket.dart';
import 'package:thea/models/play.dart';
import 'package:thea/theme/app_theme.dart';

import '../models/booking_stage.dart';
import '../widgets/pdf_file_generator.dart';
import 'chat_screen.dart';
import 'my_tickets_screen.dart';


class ConfirmationScreen extends StatelessWidget {
  final BoughtTicket ticket;

  const ConfirmationScreen({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  Widget _buildAppBarProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Icon(Icons.crop_original, color: AppColors.green),
        Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.calendar_today, color: AppColors.green),
        Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.chair, color: AppColors.green),
        Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.credit_card, color: AppColors.green),
        Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.star_border, color: Colors.black),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = "${ticket.date.day}/${ticket.date.month}/${ticket.date.year}";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        title: _buildAppBarProgress(),
        centerTitle: true,
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirmation',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ]
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.container,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
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
                                ticket.play.title ,
                                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${ticket.play.hall} - ${ticket.seats.join(', ')}',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                formattedDate,
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ticket.time,
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                ticket.isPaid ? 'Already Payed' : 'Payment up front',
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await generateTicketPdf(
                        title: ticket.play.title ?? '',
                        imageUrl: ticket.play.imageUrl ?? 'assets/images/logo.png',
                        selectedDate: ticket.date,
                        selectedTime: ticket.time,
                        selectedSeats: ticket.seats,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('Download your ticket', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement cancel ticket functionality
                      print('Cancel your ticket pressed');
                      // You might want to show a confirmation dialog before canceling
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('Cancel your ticket', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 80.0), // To avoid overlap with the fixed widget
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: (){
                      navigate(context, BookingStage.confirmation);
                      },
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/bot_avatar.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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