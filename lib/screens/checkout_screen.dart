import 'package:flutter/material.dart';
import 'package:thea/models/booking_stage.dart';
import 'package:thea/models/play.dart';
import 'package:thea/theme/app_theme.dart';

import '../models/bought_ticket.dart';
import '../util/shared_preferences.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'confirmation_screen.dart';
import 'my_tickets_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final Play play;
  final DateTime selectedDate;
  final String selectedTime;
  final List<String> selectedSeats;

  const CheckoutScreen({
    Key? key,
    required this.play,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSeats,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardholderNameController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _ccvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalPrice = widget.selectedSeats.length * (widget.play.regularTickets.price ?? 25); // Default price if not available

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor:isDark ? Colors.blueGrey.shade800.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.crop_original, color: isDark ? AppColorsDark.green : AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            Icon(Icons.calendar_today, color: isDark ? AppColorsDark.green : AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            Icon(Icons.chair, color: isDark ? AppColorsDark.green : AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            const Icon(Icons.credit_card, color: Colors.black87),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            Icon(Icons.star_border, color: isDark ? Colors.grey[600] : Colors.grey[400]),
          ],
        ),
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
                    const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ]
                ),
                const SizedBox(height: 16.0),
                // Placeholder for the card image display
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDark ? AppColorsDark.blue : Colors.blue[700],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Visa Prepaid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset('assets/images/thing.png', height: 50), // Replace with your Visa logo asset
                      ),
                      const SizedBox(height: 5.0),
                      const Text('4000 1234 5678 9010', style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 60.0),
                          const Text('VALID\nTHRU', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          const SizedBox(width: 4.0),
                          const Text('12/24', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            const Text('A. MILLER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/images/visa_logo.png', height: 30), // Replace with your Visa logo asset
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDark ? AppColorsDark.container : AppColors.container,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildFormField(controller: _cardNumberController, labelText: 'Card Number', keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter card number';
                              }
                              if (value.length != 16) {
                                return 'Card number must be 16 digits';
                              }
                            },
                          onHelpPressed: () {
                            _showInfoDialog(context, 'Card Number Help', 'Enter the 16-digit card number as shown on the card above: 4000 1234 5678 9010');
                          },
                        ),
                        const SizedBox(height: 12.0),
                        _buildFormField(controller: _cardholderNameController, labelText: 'Cardholder\'s Name', keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter cardholder\'s name';
                              }
                              return null;
                            },
                          onHelpPressed: () {
                            _showInfoDialog(context, 'Cardholder\'s Name Help', 'Enter the name as it appears on the card above: A. MILLER');
                          },
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _buildFormField(controller: _monthController, labelText: 'Month', keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter month';
                                    }
                                    if (int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 12) {
                                      return 'Invalid month';
                                    }
                                    return null;
                                  },
                                onHelpPressed: () {
                                  _showInfoDialog(context, 'Month Help', 'Enter the two-digit month (MM) from the "VALID THRU" date on the card above: 12');
                                },),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: _buildFormField(controller: _yearController, labelText: 'Year', keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter year';
                                    }
                                    if (value.length != 2 && value.length != 4) {
                                      return 'Invalid year format';
                                    }
                                    return null;
                                  },
                                onHelpPressed: () {
                                  _showInfoDialog(context, 'Year Help', 'Enter the last two digits of the year (YY) from the "VALID THRU" date on the card above: 24');
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        _buildFormField(controller: _ccvController, labelText: 'CCV', keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter CCV';
                              }
                              if (value.length != 3) {
                                return 'CCV must be 3 digits';
                              }
                              return null;
                            },
                          onHelpPressed: () {
                            _showInfoDialog(context, 'CCV Help', 'The CCV or CVV is a 3-digit security code typically found on the back of your card, usually near the signature strip.');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total: ${totalPrice}€',
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ]
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleCheckout(isPayingNow: true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? AppColorsDark.blue : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      handleCheckout(isPayingNow: false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark? Colors.black : Colors.black12,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Pay Later', style: TextStyle(color: Colors.white)),
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
                    onTap: () {
                      navigate(context, BookingStage.checkout);
                    },
                    child: const CircleAvatar(
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

  // Function to show an information dialog
  void _showInfoDialog(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: isDark ? Colors.grey[400] : Colors.black, // Set the text color to black
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Widget for a single form field
  Widget _buildFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    VoidCallback? onHelpPressed,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        filled: true,
        fillColor: isDark ? Colors.grey[200] : Colors.white,
        labelStyle: const TextStyle(color: AppColors.grey),
        floatingLabelStyle: TextStyle(color: isDark ? Colors.black : Colors.black38),
        suffixIcon: IconButton(
          icon: Icon(Icons.info_outline, color: isDark ? Colors.white : Colors.grey[600]),
          onPressed: onHelpPressed,

        ),
      ),
      validator: validator,
    );
  }

  void handleCheckout({required bool isPayingNow}) {
    showPaymentConfirmationDialog(
      context: context,
      title: isPayingNow ? 'Confirm Payment' : 'Confirm Reservation',
      message: isPayingNow
          ? 'Are you sure you want to pay now and book your tickets?'
          : 'Are you sure you want to reserve your tickets and pay later?',
      onConfirmed: () async {
        var ticket = BoughtTicket(
          play: widget.play,
          date: widget.selectedDate,
          time: widget.selectedTime,
          seats: widget.selectedSeats,
          totalPrice: widget.selectedSeats.length * (widget.play.regularTickets.price).toDouble(),
          isPaid: isPayingNow,
        );
        addBoughtTicket(ticket);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmationScreen(ticket: ticket,),
          ),
        );
      },
    );
  }

  Future<void> showPaymentConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirmed,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close dialog
                    },
                    child: const Text('Cancel'),
                    style: TextButton.styleFrom(
                      foregroundColor: isDark ? Colors.white : Colors.black, // Set the text color to black
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close dialog
                      onConfirmed(); // Proceed
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}