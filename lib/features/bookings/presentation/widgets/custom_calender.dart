import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedDate: _selectedDate,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            if (args.value is DateTime) {
              print(args.value.hashCode);
              setState(() {
                _selectedDate = args.value;
                print(_selectedDate);
              });
            }
          },
          monthViewSettings: DateRangePickerMonthViewSettings(
            firstDayOfWeek: 7, // Sunday
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              textStyle: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(fontSize: 14, color: Colors.black87),
            todayTextStyle: TextStyle(fontSize: 14, color: Colors.blue),
          ),
          selectionColor: Colors.blue,
          todayHighlightColor: Colors.blue,
        ),
      ),
    );
  }
}
