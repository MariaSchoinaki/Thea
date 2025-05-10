import 'package:flutter/material.dart';
import 'package:thea/models/play.dart';
import 'package:thea/theme/app_theme.dart';

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
    final totalPrice = widget.selectedSeats.length * (widget.play.regularTickets.price ?? 25); // Default price if not available

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor:theme.appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.crop_original, color: AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            const Icon(Icons.calendar_today, color: AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            const Icon(Icons.chair, color: AppColors.green),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            const Icon(Icons.credit_card, color: Colors.black87),
            const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
            const Icon(Icons.star_border, color: AppColors.grey),
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
                    color: Colors.blue[700],
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
                    color: AppColors.container,
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
                        print('Processing payment...');
                        print('Play: ${widget.play.title}');
                        print('Date: ${widget.selectedDate}');
                        print('Time: ${widget.selectedTime}');
                        print('Seats: ${widget.selectedSeats}');
                        print('Card Number: ${_cardNumberController.text}');
                        print('Cardholder Name: ${_cardholderNameController.text}');
                        print('Month: ${_monthController.text}');
                        print('Year: ${_yearController.text}');
                        print('CCV: ${_ccvController.text}');
                        // Navigate to a confirmation screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationScreen(play: widget.play, selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, selectedSeats: widget.selectedSeats),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18.0),
                    ),
                    child: const Text('Pay', style: TextStyle(color: Colors.white)),
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
                      //TODO: implement chatbot screen
                      print('Chatbot avatar tapped');
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

  // Function to show an information dialog
  void _showInfoDialog(BuildContext context, String title, String content) {
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
                foregroundColor: Colors.black, // Set the text color to black
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
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey)),
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: AppColors.grey),
        floatingLabelStyle: const TextStyle(color: Colors.black38),
        suffixIcon: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: onHelpPressed,
        ),
      ),
      validator: validator,
    );
  }
}