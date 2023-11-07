// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

double percentualGordura(
    Map<String, double> dobras, String birth, String gender) {
  double percentualGordura = 0;
  double bodyDensity = 0;
  double skinSum = 0;
  for (var element in dobras.values) {
    skinSum += element;
  }
  double skinSumSquared = skinSum * skinSum;
  DateTime today = DateTime.now();
  DateTime birthDay = DateFormat('dd/MM/yyyy').parse(birth);
  int age = today.year - birthDay.year;
  if (today.month > birthDay.month ||
      (today.month == birthDay.month && (today.day > birthDay.day))) {
    age--;
  }

  if (gender == 'M') {
    bodyDensity = 1.112 -
        (0.00043499 * skinSum) +
        (0.00000055 * skinSumSquared) -
        (0.00028826 * age);
    percentualGordura = ((495 / bodyDensity) - 450);
  } else if (gender == 'F') {
    bodyDensity = 1.097 -
        (0.00046971 * skinSum) +
        (0.00000056 * skinSumSquared) -
        (0.00012828 * age);
    percentualGordura = ((495 / bodyDensity) - 450) * 100;
  }

  return percentualGordura;
}

Future<String> getId(String email, String collection) async {
  QuerySnapshot query = await firestore
      .collection(collection)
      .where('email', isEqualTo: email)
      .get();
  return query.docs.first.id.toString();
}

Future<String> getIdFromCollectionGroup(String email, String collection) async {
  QuerySnapshot query = await firestore
      .collectionGroup(collection)
      .where('email', isEqualTo: email)
      .get();
  return query.docs.first.id.toString();
}

Future<void> uploadPerimetrias(Map<String, double> map, String email) async {
  String userID = await getId(email, 'evaluation');
  await firestore
      .collection('evaluation')
      .doc(userID.toString())
      .collection('perimetrias')
      .add({
    'dataAvaliacao':
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    'pescoco': map['pescoco'],
    'peitoral': map['peitoral'],
    'bicE': map['bicE'],
    'bicD': map['bicD'],
    'antE': map['antE'],
    'antD': map['antD'],
    'cintura': map['cintura'],
    'quadril': map['quadril'],
    'coxaE': map['coxaE'],
    'coxaD': map['coxaD'],
    'pantE': map['pantE'],
    'pantD': map['pantD'],
    'email': email
  });
}

Future<void> uploadDobras(
    Map<String, double> map, String email, String birth, String gender) async {
  String userID = await getId(email, 'evaluation');
  await firestore
      .collection('evaluation')
      .doc(userID.toString())
      .collection('dobras')
      .add({
    'dataAvaliacao':
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    'dobraPeitoral': map['dobraPeitoral'],
    'axial': map['axial'],
    'subscapular': map['subscapular'],
    'triciptal': map['triciptal'],
    'suprailiaca': map['suprailiaca'],
    'abdominal': map['abdominal'],
    'coxal': map['coxal'],
    'percentualGordura': percentualGordura(map, birth, gender),
    'email': email
  });
}

Future<void> uploadAulas(
    String email,
    List<DateTime> selectedDays,
    Map<DateTime, String> typeOfTraining,
    Map<DateTime, TimeOfDay> hourOfTraining) async {
  List<String> diasSelecionados = [];
  for (var element in selectedDays) {
    diasSelecionados.add('${element.year}-${element.month}-${element.day}');
  }
  Map<String, String> tipoDeTreino = {};
  typeOfTraining.forEach((key, value) {
    tipoDeTreino['${key.year}-${key.month}-${key.day}'] = value;
  });
  Map<String, String> horaDoTreino = {};
  hourOfTraining.forEach((key, value) {
    horaDoTreino['${key.year}-${key.month}-${key.day}'] =
        '${value.hour}:${value.minute}';
  });
  try {
    String userIdSchedule = await getId(email, 'schedule');
    String userIdSchedules = await getIdFromCollectionGroup(email, 'schedules');
    await firestore
        .collection('schedule')
        .doc(userIdSchedule)
        .collection('schedules')
        .doc(userIdSchedules)
        .update({
      'selectedDays': diasSelecionados,
      'typeOfTraining': tipoDeTreino,
      'hourOfTraining': horaDoTreino
    });
  } catch (e) {
    await firestore.collection('schedule').add({'email': email});
    String userId = await getId(email, 'schedule');
    await firestore
        .collection('schedule')
        .doc(userId)
        .collection('schedules')
        .add({
      'selectedDays': diasSelecionados,
      'typeOfTraining': tipoDeTreino,
      'hourOfTraining': horaDoTreino,
      'email': email
    });
  }
}

Future<void> getSchedule(List<DateTime> schedule) async {
  QuerySnapshot query = await firestore.collectionGroup('schedules').get();
  List<QueryDocumentSnapshot> docs = query.docs;
  schedule.clear();
  for (var element in docs) {
    for (String date in element['selectedDays']) {
      List<String> newDate = date.split('-');
      if (newDate[1].length == 1) newDate[1] = '0${newDate[1]}';
      if (newDate[2].length == 1) newDate[2] = '0${newDate[2]}';
      String formattedDate = newDate.join('-');
      if (!schedule.contains(DateTime.parse(formattedDate))) {
        schedule.add(DateTime.utc(int.parse(newDate[0]), int.parse(newDate[1]),
            int.parse(newDate[2])));
      }
    }
  }
}

Future<List<dynamic>> getScheduleForEmail(String email) async {
  try {
    String userId = await getId(email, 'schedule');
    QuerySnapshot query = await firestore
        .collection('schedule')
        .doc(userId)
        .collection('schedules')
        .get();
    QueryDocumentSnapshot doc = query.docs.first;
    return doc['selectedDays'];
  } catch (e) {
    return [];
  }
}

Future<Map<DateTime, TimeOfDay>> getHourOfTrainingForEmail(String email) async {
  try {
    String userId = await getId(email, 'schedule');
    QuerySnapshot query = await firestore
        .collection('schedule')
        .doc(userId)
        .collection('schedules')
        .get();
    QueryDocumentSnapshot doc = query.docs.first;
    Map<DateTime, TimeOfDay> map = {};
    doc['hourOfTraining'].forEach((key, value) {
      List<String> date = key.split('-');
      if (date[1].length == 1) date[1] = '0${date[1]}';
      if (date[2].length == 1) date[2] = '0${date[2]}';
      List<String> hour = value.split(':');
      map[DateTime.utc(
              int.parse(date[0]), int.parse(date[1]), int.parse(date[2]))] =
          TimeOfDay(hour: int.parse(hour[0]), minute: int.parse(hour[1]));
    });
    return map;
  } catch (e) {
    return {};
  }
}

Future<Map<DateTime, String>> getTypeOfTrainingForEmail(String email) async {
  try {
    String userId = await getId(email, 'schedule');
    QuerySnapshot query = await firestore
        .collection('schedule')
        .doc(userId)
        .collection('schedules')
        .get();
    QueryDocumentSnapshot doc = query.docs.first;
    Map<DateTime, String> map = {};
    doc['typeOfTraining'].forEach((key, value) {
      List<String> date = key.split('-');
      if (date[1].length == 1) date[1] = '0${date[1]}';
      if (date[2].length == 1) date[2] = '0${date[2]}';
      map[DateTime.utc(
          int.parse(date[0]), int.parse(date[1]), int.parse(date[2]))] = value;
    });
    return map;
  } catch (e) {
    return {};
  }
}

Future<void> getHours(Map<DateTime, List<TimeOfDay>> hours) async {
  QuerySnapshot query = await firestore.collectionGroup('schedules').get();
  List<QueryDocumentSnapshot> docs = query.docs;
  hours.clear();
  for (var element in docs) {
    element['hourOfTraining'].entries.forEach((e) {
      List<String> newDate = e.key.split('-');
      if (newDate[1].length == 1) newDate[1] = '0${newDate[1]}';
      if (newDate[2].length == 1) newDate[2] = '0${newDate[2]}';
      var hourAndMinute = e.value.split(':');
      var timeOfDay = TimeOfDay(
          hour: int.parse(hourAndMinute[0]),
          minute: int.parse(hourAndMinute[1]));
      hours.update(
        DateTime.utc(int.parse(newDate[0]), int.parse(newDate[1]),
            int.parse(newDate[2])),
        (existingValue) {
          existingValue.add(timeOfDay);
          return existingValue;
        },
        ifAbsent: () => [timeOfDay],
      );
    });
  }
}

Future<void> getType(Map<DateTime, List<String>> types) async {
  QuerySnapshot query = await firestore.collectionGroup('schedules').get();
  List<QueryDocumentSnapshot> docs = query.docs;
  types.clear();
  for (var element in docs) {
    element['typeOfTraining'].entries.forEach((e) {
      List<String> newDate = e.key.split('-');
      if (newDate[1].length == 1) newDate[1] = '0${newDate[1]}';
      if (newDate[2].length == 1) newDate[2] = '0${newDate[2]}';
      types.update(
        DateTime.utc(int.parse(newDate[0]), int.parse(newDate[1]),
            int.parse(newDate[2])),
        (existingValue) {
          existingValue.add(e.value);
          return existingValue;
        },
        ifAbsent: () => [e.value],
      );
    });
  }
}

Future<void> registerSingleStudent(
    String pass,
    String firstName,
    String lastName,
    String sex,
    String birth,
    String email,
    String phone,
    String typeOfStudent,
    List<bool> daysOfTraining,
    List<TimeOfDay> hoursOfTraining,
    List<String> typeOfTraining) async {
  List<String> trainingDays = [];
  for (bool value in daysOfTraining) {
    trainingDays.add(value.toString());
  }
  const int weekLength = 7;
  Map<String, List<String>> hourAndTypeOfTraining = {};
  for (int i = 0; i < weekLength; i++) {
    if (hoursOfTraining[i].minute.toString().length == 1) {
      hourAndTypeOfTraining[i.toString()] = [
        '${hoursOfTraining[i].hour}:0${hoursOfTraining[i].minute}',
        typeOfTraining[i]
      ];
    } else {
      hourAndTypeOfTraining[i.toString()] = [
        '${hoursOfTraining[i].hour}:${hoursOfTraining[i].minute}',
        typeOfTraining[i]
      ];
    }
  }
  await auth.createUserWithEmailAndPassword(email: email, password: pass);
  await auth.currentUser?.sendEmailVerification();
  firestore.collection('users').add({
    'firstName': firstName,
    'lastName': lastName,
    'gender': sex,
    'birthDay': birth,
    'email': email,
    'phone': phone,
    'typeOfStudent': typeOfStudent,
    'daysOfTraining': trainingDays,
    'hourAndTypeOfTraining': hourAndTypeOfTraining,
    'role': 'aluno'
  });
}

Future<void> registerCoupleStudents(
    String pass1,
    String pass2,
    String firstName1,
    String lastName1,
    String sex1,
    String birth1,
    String email1,
    String phone1,
    String firstName2,
    String lastName2,
    String sex2,
    String birth2,
    String email2,
    String phone2,
    String typeOfStudent,
    List<bool> daysOfTraining,
    List<TimeOfDay> hoursOfTraining,
    List<String> typeOfTraining) async {
  List<String> trainingDays = [];
  for (bool value in daysOfTraining) {
    trainingDays.add(value.toString());
  }
  const int weekLength = 7;
  Map<String, List<String>> hourAndTypeOfTraining = {};
  for (int i = 0; i < weekLength; i++) {
    if (daysOfTraining[i]) {
      if (hoursOfTraining[i].minute.toString().length == 1) {
        hourAndTypeOfTraining[i.toString()] = [
          '${hoursOfTraining[i].hour}:0${hoursOfTraining[i].minute}',
          typeOfTraining[i]
        ];
      } else {
        hourAndTypeOfTraining[i.toString()] = [
          '${hoursOfTraining[i].hour}:${hoursOfTraining[i].minute}',
          typeOfTraining[i]
        ];
      }
    } else {
      hourAndTypeOfTraining[i.toString()] = [];
    }
  }
  await auth.createUserWithEmailAndPassword(email: email1, password: pass1);
  await auth.currentUser?.sendEmailVerification();
  firestore.collection('users').add({
    'firstName': firstName1,
    'lastName': lastName1,
    'gender': sex1,
    'birthDay': birth1,
    'email': email1,
    'phone': phone1,
    'typeOfStudent': typeOfStudent,
    'daysOfTraining': trainingDays,
    'hourAndTypeOfTraining': hourAndTypeOfTraining,
    'partner': '$firstName2 $lastName2',
    'partnerEmail': email2,
    'role': 'aluno'
  });
  await auth.createUserWithEmailAndPassword(email: email2, password: pass2);
  await auth.currentUser?.sendEmailVerification();
  firestore.collection('users').add({
    'firstName': firstName2,
    'lastName': lastName2,
    'gender': sex2,
    'birthDay': birth2,
    'email': email2,
    'phone': phone2,
    'typeOfStudent': typeOfStudent,
    'daysOfTraining': trainingDays,
    'hourAndTypeOfTraining': hourAndTypeOfTraining,
    'partner': '$firstName1 $lastName1',
    'partnerEmail': email1,
    'role': 'aluno'
  });
}

Future<void> getDaysOfTraining(
    String email, List<int> daysOfTraining, List<DateTime> selectedDays, Map<DateTime, bool> picked) async {
  try {
    String userId = await getId(email, 'users');
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection('users').doc(userId).get();
    List<bool> diasDeTreino = [];
    for (String day in doc['daysOfTraining']) {
      diasDeTreino.add(bool.parse(day));
    }
    for (int i = 1; i < diasDeTreino.length; i++) {
      if (diasDeTreino[i - 1] == true) daysOfTraining.add(i);
    }
    DateTime now = DateTime.now();
    for (int i = 1; i <= 31; i++) {
      for (int day in daysOfTraining) {
        if (DateTime.utc(now.year, now.month, i).weekday == day) {
          selectedDays.add(DateTime.utc(now.year, now.month, i));
          picked[DateTime.utc(now.year, now.month, i)] = true;
        }
      }
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> getHourAndTypeOfTraining(
    String email,
    Map<int, List<dynamic>> hourAndTypeOfTraining,
    Map<DateTime, String> typeOfTraining,
    Map<DateTime, TimeOfDay> hourOfTraining) async {
  try {
    String userId = await getId(email, 'users');
    DocumentSnapshot doc =
        await firestore.collection('users').doc(userId).get();
    Map<int, List<dynamic>> horaETipoDeTreino = {};
    Map<String, dynamic> mapDoc = doc['hourAndTypeOfTraining'];
    mapDoc.forEach((key, value) {
      List<String> hourAndMinute = value[0].split(':');
      if (hourAndMinute[0].length == 1) {
        hourAndMinute[0] = '0${hourAndMinute[0]}';
      }
      if (hourAndMinute[1].length == 1) {
        hourAndMinute[1] = '0${hourAndMinute[1]}';
      }
      horaETipoDeTreino[int.parse(key)] = [
        TimeOfDay(
            hour: int.parse(hourAndMinute[0]),
            minute: int.parse(hourAndMinute[1])),
        value[1]
      ];
    });
    DateTime now = DateTime.now();
    for (int i = 1; i <= 31; i++) {
      horaETipoDeTreino.forEach((key, value) {
        if (DateTime.utc(now.year, now.month, i).weekday == key) {
          hourOfTraining[DateTime.utc(now.year, now.month, i)] = value[0];
          typeOfTraining[DateTime.utc(now.year, now.month, i)] = value[1];
        }
      });
    }
    print(hourOfTraining);
    print(typeOfTraining);
  } catch (e) {
    throw Exception(e);
  }
}
