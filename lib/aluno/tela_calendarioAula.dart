// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioAulas extends StatefulWidget {
  const CalendarioAulas({super.key});

  @override
  State<CalendarioAulas> createState() => _CalendarioAulasState();
}

class _CalendarioAulasState extends State<CalendarioAulas> {
  final DateTime _focusedDay = DateTime.now();
  final List<DateTime> _aulas = [
    DateTime.utc(2023, 8, 3),
    DateTime.utc(2023, 8, 5),
    DateTime.utc(2023, 8, 7),
    DateTime.utc(2023, 8, 10),
    DateTime.utc(2023, 8, 12),
    DateTime.utc(2023, 8, 14),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Calendário de Aulas",
            style: TextStyle(fontSize: 40),
          ),
        ),
        Container(
          width: 350,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 9,
                    blurRadius: 5,
                    offset: const Offset(0, 0))
              ]),
          child: TableCalendar(
            firstDay:
                DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
            lastDay:
                DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0),
            calendarFormat: CalendarFormat.month,
            focusedDay: _focusedDay,
            calendarStyle: const CalendarStyle(
                selectedDecoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                selectedTextStyle: TextStyle(color: Colors.black)),
            enabledDayPredicate: (day) {
              return _aulas.contains(day);
            },
            selectedDayPredicate: (day) {
              return _aulas.contains(day);
            },
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            rowHeight: 40,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Você possui ${_aulas.length} aulas agendadas para esse mês",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
