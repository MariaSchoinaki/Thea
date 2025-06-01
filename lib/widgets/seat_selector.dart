import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeatSelector extends StatefulWidget {
  final Set<String> availableSeats;
  final Set<String> selectedSeats;
  final void Function(String seatId, bool selected) onSeatTap;
  final bool isDark;

  const SeatSelector({
    super.key,
    required this.availableSeats,
    required this.selectedSeats,
    required this.onSeatTap,
    this.isDark = false,
  });

  @override
  State<SeatSelector> createState() => _SeatSelectorState();
}

class _SeatSelectorState extends State<SeatSelector> {

  final List<List<String?>> _seatLayout = [
    ['A1', 'A2', 'A3', 'A4', null, 'A5', 'A6', 'A7'],
    ['B1', 'B2', 'B3', 'B4', null, 'B5', 'B6', 'B7'],
    ['C1', 'C2', 'C3', 'C4', null, 'C5', 'C6', 'C7'],
    ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8'],
    ['E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8'],
    ['F1', 'F2', 'F3', 'F4', null, 'F5', 'F6', 'F7'],
  ];


  Widget _buildSeat(String? seatNumber) {
    if (seatNumber == null) return const SizedBox(width: 41);

    bool isBooked = !widget.availableSeats.contains(seatNumber);
    bool isSelected = widget.selectedSeats.contains(seatNumber);
    bool isDisabledSeat = seatNumber.startsWith('A');

    Color seatColor;
    if (isBooked) {
      seatColor = Colors.grey[400]!;
    } else if (isSelected) {
      seatColor = Colors.orange[400]!;
    } else if (isDisabledSeat) {
      seatColor = Colors.blueAccent;
    } else {
      seatColor = widget.isDark ? Colors.green[700]! : Colors.green[400]!;
    }

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
        widget.onSeatTap(seatNumber, !isSelected);
      },
      child: Container(
        width: 35,
        height: 28,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: seatColor,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _seatLayout.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map(_buildSeat).toList(),
        );
      }).toList(),
    );
  }
}
