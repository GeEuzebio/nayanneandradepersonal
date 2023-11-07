// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nayanneandradepersonal/controlers/firebase_controlers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import '../controlers/events_controler.dart';

class TelaAulas extends StatefulWidget {
  const TelaAulas({super.key});

  @override
  State<TelaAulas> createState() => _TelaAulasState();
}

class _TelaAulasState extends State<TelaAulas> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final List<DateTime> _selectedDays = [];
  final Map<DateTime, List<TimeOfDay>> _hoursOfTraining = {};
  final Map<DateTime, List<String>> _typesOfTraining = {};
  final Map<DateTime, List<Event>> events = {};

  Future<void> getEvents(
      Map<DateTime, List<Event>> events,
      List<DateTime> schedule,
      Map<DateTime, List<TimeOfDay>> hours,
      Map<DateTime, List<String>> typeOfTraining) async {
    await getSchedule(schedule);
    await getHours(hours);
    await getType(typeOfTraining);
    Map<DateTime, List<Event>> eventos = {};
    Set<DateTime> processedDays = {};

    for (DateTime day in schedule) {
      if (!processedDays.contains(day)) {
        processedDays.add(day);
        eventos[day] ??= [];
        List<TimeOfDay>? hour = hours[day];
        List<String>? type = typeOfTraining[day];
        for (int i = 0; i < hour!.length; i++) {
          eventos[day]!.add(Event(day, hour[i], type![i]));
        }
      }
    }
    setState(() {
      events.clear();
      events.addAll(eventos);
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents(events, _selectedDays, _hoursOfTraining, _typesOfTraining);
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    List<Event> getEventsForDay(DateTime day) {
      return events[day] ?? [];
    }

    Future<void> sendMessage() async {
      final url =
          Uri.parse('https://cluster.apigratis.com/api/v1/whatsapp/sendText');

      final headers = {
        'Content-Type': 'application/json',
        'SecretKey': 'e3b0e4b8-7670-47b6-8543-47f869ccc90e',
        'PublicToken': '1baaeb27-5c45-4d5e-a491-5eb929e22c4e',
        'DeviceToken': 'ed11ea3a-7041-42a5-9e69-47bfbddb14d1',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BsYXRhZm9ybWEuYXBpYnJhc2lsLmNvbS5ici9zb2NpYWwvZ29vZ2xlL2NhbGxiYWNrIiwiaWF0IjoxNjg3NDUzMzU3LCJleHAiOjE3MTg5ODkzNTcsIm5iZiI6MTY4NzQ1MzM1NywianRpIjoiS3ZuY2VtZTF3ZFlpZ3IxMSIsInN1YiI6IjM2MjUiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.ajm-93tzryEUx1by6LC-_b3fkb8TQkJDNQQ6g4uxlIA',
      };

      final message = {
        "number": "5585999818509",
        "text": "Oiê, treina hoje?",
        "time_typing": 1
      };

      try {
        await http.post(url, headers: headers, body: jsonEncode(message));
      } catch (e) {
        throw Exception(e);
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            elevation: 2,
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(now.year, now.month, 1),
              lastDay: DateTime.utc(now.year, now.month + 1, 0),
              calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,),
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              eventLoader: (day){
                return getEventsForDay(day);
              },
              selectedDayPredicate: (day) {
                return isSameDay(day, _selectedDay);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            ),
          ),
          Flexible(
            child: events.containsKey(_selectedDay)
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: events[_selectedDay]?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(events[_selectedDay]![index].day.toString()),
                        subtitle:
                            Text(events[_selectedDay]![index].hour.toString()),
                        trailing: ElevatedButton(
                          onPressed: sendMessage,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Icon(FontAwesomeIcons.whatsapp),
                        ),
                      );
                    },
                  )
                : const Center(
                    child:
                        Text('Nenhuma aula agendada para o dia selecionado.')),
          )
        ],
      ),
    );
  }
}
