import 'package:flutter/material.dart';
import 'package:thea/models/play.dart';
import 'package:thea/theme/app_theme.dart';
import 'package:intl/intl.dart';

import '../models/booking_stage.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'checkout_screen.dart';
import 'my_tickets_screen.dart';

class BookingScreen extends StatefulWidget {
  final Play play;

  const BookingScreen({Key? key, required this.play}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _selectedKey;
  List<String> _selectedSeats = [];
  BookingStage stage = BookingStage.dateTimeSelection;
  // Example seat layout data (replace with your actual data)
  List<List<String?>> _seatLayout = [
    ['A1', 'A2', 'A3', 'A4', null, 'A5', 'A6', 'A7'],
    ['B1', 'B2', 'B3', 'B4', null, 'B5', 'B6', 'B7'],
    ['C1', 'C2', 'C3', 'C4', null, 'C5', 'C6', 'C7'],
    ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8'],
    ['E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8'],
    ['F1', 'F2', 'F3', 'F4', null, 'F5', 'F6', 'F7'],
  ];

  Widget _buildSeat(String? seatNumber) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    if (seatNumber == null) {
      return const SizedBox(width: 41);
    }

    String formattedDateKey = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(_selectedDate!);
    final availableSeatsForDate = widget.play.availableDates[formattedDateKey];
    final _availableSeats = availableSeatsForDate != null ? availableSeatsForDate[_selectedKey] : null;

    bool isBooked = _availableSeats == null || !_availableSeats.contains(seatNumber);
    bool isSelected = _selectedSeats.contains(seatNumber);

    bool isDisabledSeat = seatNumber.startsWith('A');

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
        setState(() {
          if (isSelected) {
            _selectedSeats.remove(seatNumber);
          } else {
            _selectedSeats.add(seatNumber);
          }
        });
      },
      child: Container(
        width: 35,
        height: 28,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isBooked
              ? Colors.grey[400]
              : isSelected
              ? Colors.orange[400]
              : isDisabledSeat
              ? Colors.blueAccent
              : (isDark ? AppColorsDark.green : Colors.green[400]),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                seatNumber,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              if (isDisabledSeat) ...[
                const SizedBox(width: 2),
                const Icon(
                  Icons.accessible,
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatLayout() {
    return Column(
      children: _seatLayout.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((seat) => _buildSeat(seat)).toList(),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Set<DateTime> availableDateSet = widget.play.availableDates.keys
        .map((dateStr) => DateTime.parse(dateStr))
        .toSet();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: isDark ? Colors.blueGrey.shade800.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        title: _buildStepIcons(),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.play.title ?? '',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                if (widget.play.imageUrl != null)
                  Image.asset(
                    widget.play.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  const SizedBox.shrink(),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Stage 1', style: theme.textTheme.titleMedium),
                    Text(widget.play.runtime ?? '', style: theme.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text('Stage: ${widget.play.stage ?? ''}', style: theme.textTheme.titleMedium),
                const SizedBox(height: 24.0),
                const Text(
                  'Choose Day',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Theme(
                  data: Theme.of(context).copyWith(
                    datePickerTheme: DatePickerThemeData(
                      dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.grey[300]; // Grey circular background
                        }
                        return null;
                      }),
                      dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.green; // Green text
                        }
                        return null;
                      }),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: _selectedDate ?? (availableDateSet.isNotEmpty ? availableDateSet.first : DateTime.now()),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                    onDateChanged: (DateTime newDate) {
                      setState(() {
                        _selectedDate = newDate;
                        _selectedTime = null;
                        _selectedSeats.clear();
                        stage = BookingStage.dateTimeSelection;
                      });
                    },
                    selectableDayPredicate: (DateTime day) {
                      return availableDateSet.contains(DateTime(day.year, day.month, day.day));
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                if (_selectedDate != null) ...[
                  const Text('Choose Time', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      if (widget.play.afternoon != null && widget.play.afternoon!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(widget.play.afternoon!),
                            selected: _selectedTime == widget.play.afternoon,
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedTime = selected ? widget.play.afternoon : null;
                                _selectedSeats.clear(); // Clear selected seats on time change
                                _selectedKey  = selected ? 'afternoon' : null;
                                stage = BookingStage.seatSelection;
                              });
                            },
                            selectedColor: isDark ? AppColorsDark.green : AppColors.green,
                          ),
                        ),
                      if (widget.play.night != null && widget.play.night!.isNotEmpty)
                        ChoiceChip(
                          label: Text(widget.play.night!),
                          selected: _selectedTime == widget.play.night,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedTime = selected ? widget.play.night : null;
                              _selectedSeats.clear(); // Clear selected seats on time change
                              _selectedKey  = selected ? 'night' : null;
                              stage = BookingStage.seatSelection;
                            });
                          },
                          selectedColor: isDark ? AppColorsDark.green : AppColors.green,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  if (_selectedTime != null) ...[
                    const Text(
                      'Choose Seat',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    _buildSeatLayout(),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedSeats.isNotEmpty
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(play: widget.play, selectedDate: _selectedDate!, selectedTime: _selectedTime!, selectedSeats: _selectedSeats, slot: _selectedKey),
                            ),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppColorsDark.coral : AppColors.coral,
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ],
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
                      navigate(context, stage);
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

  Widget _buildStepIcons() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color calendarColor = _selectedDate != null
        ? (isDark ? AppColorsDark.green : AppColors.green)
        : Colors.black87;
    final couchColor = (_selectedDate != null && _selectedTime != null) ? Colors.black87 : isDark ? Colors.grey[600] : AppColors.grey;
    final creditCardColor = (_selectedSeats.isNotEmpty) ? Colors.black87 : isDark ? Colors.grey[600] : AppColors.grey;


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.crop_original, color: isDark ? AppColorsDark.green : AppColors.green),
        const Text('-', style: TextStyle(color: AppColors.darkText , fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.calendar_today, color: calendarColor),
        const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.chair, color: couchColor),
        const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
        Icon(Icons.credit_card, color: creditCardColor),
        const Text('-', style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold, fontSize: 20)),
         Icon(Icons.star_border, color: isDark ? Colors.grey[600] : AppColors.grey),
      ],
    );
  }

}