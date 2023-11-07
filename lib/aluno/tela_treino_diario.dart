// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nayanneandradepersonal/aluno/tela_treino.dart';

class TreinoDiario extends StatefulWidget {
  const TreinoDiario({super.key});

  @override
  State<TreinoDiario> createState() => _TreinoDiarioState();
}

class _TreinoDiarioState extends State<TreinoDiario> {
  bool isChecked = false;
  Map<String, String> treinos = {
    'Treino A': 'images/biceps.png',
    'Treino B': 'images/quadricep.png',
    'Treino C': 'images/trapezius.png'
  };
  Map<String, Map<String, List<dynamic>>> exercicios = {
    'Treino A': {
      'Seated Incline Dumbbell Curl': [
        4,
        10,
        45,
        'images/Seated-Incline-Dumbbell-Curl.gif'
      ],
      'Bent Over Kickback': [
        4,
        10,
        45,
        'images/Bent-Over-Triceps-Kickback.gif'
      ],
      'One Arm Cable Curl': [
        3,
        12,
        'Super Set',
        'images/One-Arm-Cable-Curl.gif'
      ],
      'One Arm Reverse Pushdown': [
        3,
        12,
        'Super Set',
        'images/One-Arm-Reverse-Push-Down.gif'
      ]
    },
    'Treino B': {},
    'Treino C': {}
  };
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Treino Diário",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200, bottom: 30),
            child: Text(
              DateFormat("dd/MM/yyyy").format(DateTime.now()),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: treinos.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TelaTreino(entry.key, exercicios)));
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Container(
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [
                                Colors.pink.shade100,
                                Colors.pink.shade200
                              ], center: Alignment.topCenter, radius: 2),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(50.0),
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 0))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 30),
                                child: Image.asset(
                                  entry.value,
                                  width: 80,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 15, top: 5),
                          child: Image.asset(
                            'images/dumbell.png',
                            width: 45,
                            height: 45,
                          ))
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ]);
  }
}
