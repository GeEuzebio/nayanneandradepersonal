// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:nayanneandradepersonal/controlers/firebase_controlers.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controlers/events_controler.dart';

class TelaRemarcacao extends StatefulWidget {
  final String email;

  const TelaRemarcacao({required this.email, Key? key}) : super(key: key);

  @override
  State<TelaRemarcacao> createState() => _TelaRemarcacaoState();
}

class _TelaRemarcacaoState extends State<TelaRemarcacao> {
  DateTime _focusedDay = DateTime.now();
  final List<DateTime> _selectedDays = [];
  final Map<DateTime, bool> _picked = {};
  final Map<DateTime, String> _typeOfTraining = {};
  final Map<DateTime, TimeOfDay> _hourOfTraining = {};
  final List<int> _daysOfTraining = [];
  final Map<int, List<dynamic>> _hourAndTypeOfTraining = {};
  DateTime now = DateTime.now();
  Map<DateTime, List<Event>> events = {};

  Future<void> updateSchedule() async {
    List<dynamic> dates = await getScheduleForEmail(widget.email);
    _selectedDays.clear();
    for (String date in dates) {
      List<String> newDate = date.split('-');
      if (newDate[1].length == 1) newDate[1] = '0${newDate[1]}';
      if (newDate[2].length == 1) newDate[2] = '0${newDate[2]}';
      String formattedDate = newDate.join('-');
      if (!_selectedDays.contains(DateTime.parse(formattedDate))) {
        _selectedDays.add(DateTime.utc(int.parse(newDate[0]),
            int.parse(newDate[1]), int.parse(newDate[2])));
      }
    }
    setState(() {});
  }

  Future<void> updatePicked() async {
    await updateSchedule();
    for (var date in _selectedDays) {
      _picked[date] = true;
    }
  }

  Future<void> updateHours() async {
    _hourOfTraining.addAll(await getHourOfTrainingForEmail(widget.email));
  }

  Future<void> updateTypes() async {
    _typeOfTraining.addAll(await getTypeOfTrainingForEmail(widget.email));
  }

  Future<void> autoFill() async {
    if(_selectedDays.isEmpty){
      await getDaysOfTraining(widget.email, _daysOfTraining, _selectedDays, _picked);
      await getHourAndTypeOfTraining(widget.email, _hourAndTypeOfTraining, _typeOfTraining, _hourOfTraining);
      setState(() {});
    } else {
      await updatePicked();
      await updateHours();
      await updateTypes();
    }
  }

  @override
  void initState() {
    super.initState();
    autoFill();
    updatePicked();
    updateHours();
    updateTypes();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> getEventsForDay(DateTime day) {
      return events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade200,
              ),
              onPressed: () {
                uploadAulas(widget.email, _selectedDays, _typeOfTraining,
                    _hourOfTraining);
              },
              child: const Text('Agendar Aulas')),
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 2,
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(now.year, now.month, 1),
              lastDay: DateTime.utc(now.year, now.month + 1, 0),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              eventLoader: getEventsForDay,
              selectedDayPredicate: (day) {
                return _selectedDays.contains(day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (_selectedDays.contains(selectedDay)) {
                    _selectedDays.remove(selectedDay);
                    _picked.remove(selectedDay);
                    _typeOfTraining.remove(selectedDay);
                  } else {
                    _selectedDays.add(selectedDay);
                    _picked[selectedDay] = false;
                    _typeOfTraining[selectedDay] = 'Single';
                    _selectedDays.sort();
                  }
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: _selectedDays.isNotEmpty
                    ? _selectedDays.asMap().entries.map((e) {
                        // int index = e.key;
                        DateTime selectedDay = e.value;
                        return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Column(
                                children: <Widget>[
                                  const Text(
                                    'Dia da Aula',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                      '${selectedDay.day}/${selectedDay.month}')
                                ],
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  const Text(
                                    'Tipo de Aula',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  DropdownButton(
                                      value: _typeOfTraining[selectedDay],
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'Single',
                                            child: Text('Single')),
                                        DropdownMenuItem(
                                            value: 'Couple',
                                            child: Text('Couple'))
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _typeOfTraining[selectedDay] = value!;
                                        });
                                      })
                                ],
                              ),
                              trailing: SizedBox(
                                width: 190,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink.shade200),
                                  onPressed: () async {
                                    final TimeOfDay? pick = await showTimePicker(
                                        context: context,
                                        builder: (BuildContext context,
                                                Widget? child) =>
                                            MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            true),
                                                child: child!),
                                        initialTime: TimeOfDay.now(),
                                        initialEntryMode:
                                            TimePickerEntryMode.inputOnly);
                                    setState(() {
                                      _hourOfTraining[selectedDay] = pick!;
                                      _picked[selectedDay] = true;
                                    });
                                  },
                                  child: _picked[selectedDay]!
                                      ? Text(
                                          '${_hourOfTraining[selectedDay]?.format(context)}')
                                      : const Text('Selecione o horário'),
                                ),
                              ),
                            ));
                      }).toList()
                    : [const Text('Nenhuma aula marcada.')],
              ),
            ),
          )
        ],
      ),
    );
  }
}
