// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TelaTreino extends StatefulWidget {
  String treino;
  Map<String, Map<String, List<dynamic>>> exercicios;
  TelaTreino(this.treino, this.exercicios, {super.key});

  @override
  State<TelaTreino> createState() => _TelaTreinoState();
}

class _TelaTreinoState extends State<TelaTreino> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<dynamic>> exercicio = widget.exercicios.entries
        .firstWhere((element) => (element.key == widget.treino))
        .value;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.treino),
        ),
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DataTable(
                  columnSpacing: 6,
                  columns: const [
                    DataColumn(label: Text('Exercício')),
                    DataColumn(label: Text('Séries')),
                    DataColumn(label: Text('Repetições')),
                    DataColumn(label: Text('Descanso'))
                  ],
                  rows: exercicio.entries.map((e) {
                    return DataRow(cells: [
                      DataCell(
                        Text(e.key),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Image.asset(e.value[3]),
                                );
                              });
                        },
                      ),
                      DataCell(Text(e.value[0].toString())),
                      DataCell(Text(e.value[1].toString())),
                      DataCell(Text(e.value[2].toString())),
                    ]);
                  }).toList())
            ],
          ),
        ));
  }
}
