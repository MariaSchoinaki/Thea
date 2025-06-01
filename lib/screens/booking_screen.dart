import 'package:flutter/material.dart';
import 'package:thea/models/play.dart';
import 'package:thea/theme/app_theme.dart';
import 'package:intl/intl.dart';

import '../models/booking_stage.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/seat_selector.dart';
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

  Widget _buildSeatLayout() {
    String formattedDateKey = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss",
    ).format(_selectedDate!);
    final availableSeatsForDate = widget.play.availableDates[formattedDateKey];
    final _availableSeats =
        availableSeatsForDate != null
            ? availableSeatsForDate[_selectedKey]
            : null;

    return SeatSelector(
      availableSeats: _availableSeats?.toSet() ?? {},
      selectedSeats: _selectedSeats.toSet(),
      isDark: Theme.of(context).brightness == Brightness.dark,
      onSeatTap: (seatId, selected) {
        setState(() {
          if (selected) {
            _selectedSeats.add(seatId);
          } else {
            _selectedSeats.remove(seatId);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Set<DateTime> availableDateSet =
        widget.play.availableDates.keys
            .map((dateStr) => DateTime.parse(dateStr))
            .toSet();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: theme.scaffoldBackgroundColor,
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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: theme.scaffoldBackgroundColor,
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.play.imageUrl != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.asset(
                            widget.play.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.play.title ?? '',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Stage: ${widget.play.stage ?? ''}',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.play.runtime ?? '',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16,16,16,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_today, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Choose Day',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Theme(
                          data: Theme.of(context).copyWith(
                            datePickerTheme: DatePickerThemeData(
                              dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((states,) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors.grey[300]; // Grey circular background
                                    }
                                    return null;
                                  }),
                              dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((states,) {
                                    if (states.contains(WidgetState.selected)) {
                                      return Colors.green; // Green text
                                    }
                                    return null;
                                  }),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          child: CalendarDatePicker(
                            initialDate:
                                _selectedDate ??
                                (availableDateSet.isNotEmpty
                                    ? availableDateSet.first
                                    : DateTime.now()),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 90),
                            ),
                            onDateChanged: (DateTime newDate) {
                              setState(() {
                                _selectedDate = newDate;
                                _selectedTime = null;
                                _selectedSeats.clear();
                                stage = BookingStage.dateTimeSelection;
                              });
                            },
                            selectableDayPredicate: (DateTime day) {
                              return availableDateSet.contains(
                                DateTime(day.year, day.month, day.day),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                if (_selectedDate != null) ...[
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: theme.scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.access_time, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Choose Time',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              if (widget.play.afternoon.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(widget.play.afternoon),
                                    selected:
                                        _selectedTime == widget.play.afternoon,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedTime =
                                            selected
                                                ? widget.play.afternoon
                                                : null;
                                        _selectedSeats
                                            .clear(); // Clear selected seats on time change
                                        _selectedKey =
                                            selected ? 'afternoon' : null;
                                        stage = BookingStage.seatSelection;
                                      });
                                    },
                                    selectedColor:
                                        isDark
                                            ? AppColorsDark.green
                                            : AppColors.green,
                                  ),
                                ),
                              if (widget.play.night.isNotEmpty)
                                ChoiceChip(
                                  label: Text(widget.play.night),
                                  selected: _selectedTime == widget.play.night,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedTime =
                                          selected ? widget.play.night : null;
                                      _selectedSeats
                                          .clear(); // Clear selected seats on time change
                                      _selectedKey = selected ? 'night' : null;
                                      stage = BookingStage.seatSelection;
                                    });
                                  },
                                  selectedColor:
                                      isDark
                                          ? AppColorsDark.green
                                          : AppColors.green,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  if (_selectedTime != null) ...[
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: theme.scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6,16,6,16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.chair, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Choose Seat',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            _buildSeatLayout(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _selectedSeats.isNotEmpty
                                ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CheckoutScreen(
                                            play: widget.play,
                                            selectedDate: _selectedDate!,
                                            selectedTime: _selectedTime!,
                                            selectedSeats: _selectedSeats,
                                            slot: _selectedKey,
                                          ),
                                    ),
                                  );
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark ? AppColorsDark.coral : AppColors.coral,
                        ),
                        child: const Text(
                          'Book',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ],
                const SizedBox(height: 80.0,), // To avoid overlap with the fixed widget
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
                      backgroundImage: AssetImage(
                        'assets/images/bot_avatar.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyNavBar(currentIndex: 0),
    );
  }

  Widget _buildStepIcons() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color calendarColor = _selectedDate != null
        ? (isDark ? AppColorsDark.green : AppColors.green)
        : Colors.black87;
    final couchColor = _selectedSeats.isNotEmpty
        ? (isDark ? AppColorsDark.green : AppColors.green)
        : (_selectedDate != null && _selectedTime != null)
        ? (isDark ? Colors.white : Colors.black87)
        : isDark
        ? Colors.grey[600]
        : AppColors.grey;

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
