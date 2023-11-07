import 'package:flutter/material.dart';

class Event {
  final DateTime day;
  final TimeOfDay hour;
  final String typeOfTraining;

  Event(this.day, this.hour, this.typeOfTraining);

  @override
  String toString() {
    return 'Event{day: $day, hour: $hour, typeOfTraining: $typeOfTraining}';
  }
}
