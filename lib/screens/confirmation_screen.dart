import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thea/models/bought_ticket.dart';
import 'package:thea/theme/app_theme.dart';
import 'package:intl/intl.dart';
import '../models/booking_stage.dart';
import '../util/shared_preferences.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/pdf_file_generator.dart';


class ConfirmationScreen extends StatefulWidget {
  final BoughtTicket ticket;
  final String? slot;

  const ConfirmationScreen({
    super.key,
    required this.ticket,
    required this.slot,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();

}

class _ConfirmationScreenState extends State<ConfirmationScreen> {


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
    final isDark = theme.brightness == Brightness.dark;
    var ticket = widget.ticket;
    final formattedDate = "${ticket.date.day}/${ticket.date.month}/${ticket.date.year}";
    decreaseTicket();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor:theme.scaffoldBackgroundColor,
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
                    color: isDark? AppColorsDark.container : AppColors.container,
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
                                '${ticket.play.stage} - ${ticket.seats.join(', ')}',
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
                      backgroundColor: isDark? AppColorsDark.green : AppColors.green,
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
                      showCancelDialog(ticket.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? AppColorsDark.red : AppColors.red,
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
        bottomNavigationBar: MyNavBar(currentIndex: 0)
    );
  }

  void showCancelDialog(String ticketId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cancel Ticket"),
        content: widget.ticket.isPaid ? Text("Are you sure you want to cancel this ticket and get a refund?") :
                                        Text("Are you sure you want to cancel this ticket?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No", style: Theme.of(context).textTheme.bodySmall),
          ),
          ElevatedButton(
            onPressed: () async {
             increaseTicket();
             await cancelTicket(ticketId);
             Navigator.pop(context);
             setState(() {}); // Refresh ticket list
            },
            child: Text("Yes, Cancel"),
          ),
        ],
      ),
    );
  }

  void _updateTickets({required bool increase}) {
    final seats = widget.ticket.seats;
    final formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(widget.ticket.date);

    final aTickets = seats.where((seat) => seat.startsWith('A')).length;
    final regularTickets = seats.length - aTickets;

    final special = widget.ticket.play.specialNeedsTickets;
    final regular = widget.ticket.play.regularTickets;

    for (int i = 0; i < aTickets; i++) {
      increase ? special.incrementAvailableTickets() : special.decrementAvailableTickets();
    }

    for (int i = 0; i < regularTickets; i++) {
      increase ? regular.incrementAvailableTickets() : regular.decrementAvailableTickets();
    }

    final availableSeats = widget.ticket.play.availableDates[formattedDate]?[widget.slot];
    if (availableSeats != null) {
      increase ? availableSeats.addAll(seats) :availableSeats.removeWhere((seat) => seats.contains(seat));
    }
  }

  void decreaseTicket() => _updateTickets(increase: false);
  void increaseTicket() => _updateTickets(increase: true);
}