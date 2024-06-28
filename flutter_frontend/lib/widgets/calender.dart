import 'package:flutter/cupertino.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';

class Calendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const Calendar({super.key, required this.onDateSelected, required DateTime initialDate});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime _selectedDate = DateTime.now();

  Future<void> showCalendarPicker(BuildContext context) async {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final DateTime nowDate = DateTime.now();

    final DateTime? newDate = await showCupertinoCalendarPicker(
      context,
      widgetRenderBox: renderBox,
      minimumDate: nowDate.subtract(const Duration(days: 1000)),
      initialDate: _selectedDate,
      maximumDate: nowDate.add(const Duration(days: 1000)),
      onDateChanged: _onDateChanged,
    );

    if (newDate != null) {
      setState(() {
        _selectedDate = newDate;
        widget.onDateSelected(newDate);
      });
    }
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      widget.onDateSelected(newDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCalendarPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(CupertinoIcons.calendar, color: CupertinoColors.systemRed),
            const SizedBox(width: 8.0),
            _DateDisplay(selectedDate: _selectedDate),
          ],
        ),
      ),
    );
  }
}

class _DateDisplay extends StatelessWidget {
  final DateTime selectedDate;

  const _DateDisplay({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final localization = CupertinoLocalizations.of(context);
    final day = selectedDate.day;
    final month = selectedDate.month;
    final year = selectedDate.year;
    final fullMonthString = localization.datePickerMonth(month);
    final dayString = localization.datePickerDayOfMonth(day);
    final monthString = fullMonthString.substring(0, 3);
    final yearString = localization.datePickerYear(year);

    print('$monthString $dayString, $yearString');

    return Text(
      '$monthString $dayString, $yearString',
      style: const TextStyle(
        color: CupertinoColors.systemRed,
        fontSize: 17.0,
      ),
    );
  }
}
