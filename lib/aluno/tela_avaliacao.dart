// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avaliacao extends StatefulWidget {
  const Avaliacao({Key? key}) : super(key: key);

  @override
  State<Avaliacao> createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {
  @override
  Widget build(BuildContext context) {
    Map<String, double> perimetrias = {
      'Braço Direito': 28.5,
      'Braço Esquerdo': 28.5,
      'Coxa Direita': 50,
      'Coxa Esquerda': 50,
      'Cintura': 95,
      'Quadril': 123,
      'Peitoral': 105
    };
    Map<String, double> dobras = {
      'Subescapular': 67,
      'Tríceps': 39,
      'Bíceps': 18,
      'Peito': 52,
      'Médio Axilar': 42,
      'Suprailíaca': 49,
      'Abdominal': 58,
      'Coxa': 58,
      'Panturrilha': 25
    };
    List<String> items = [
      'images/front.jpg',
      'images/side.jpg',
      'images/back.jpg',
    ];
    return Center(
      child: Column(children: [
        const Text(
          "Avaliação Física",
          style: TextStyle(fontSize: 40),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 200, bottom: 30),
          child: Text(
            DateFormat("dd/MM/yyyy").format(DateTime.now()),
            style: const TextStyle(fontSize: 20),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 590,
                width: double.infinity,
                child: CarouselSlider(
                    items: items.map((e) {
                      return Image.asset(
                        e,
                        fit: BoxFit.fill,
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 550,
                        aspectRatio: 0.5,
                        viewportFraction: 0.7,
                        enlargeCenterPage: true)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: const Text(
                  'Medidas',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Perimetrias'),
                                    content: DataTable(
                                      columns: const [
                                        DataColumn(label: Text('Segmento')),
                                        DataColumn(label: Text('Medida(cm)'))
                                      ],
                                      rows: perimetrias.entries.map((e) {
                                        return DataRow(cells: [
                                          DataCell(Text(e.key)),
                                          DataCell(Text(e.value.toString()))
                                        ]);
                                      }).toList(),
                                    ),
                                  );
                                });
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('images/tape-measure.png'),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Perimetrias',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text('Dobras Cutâneas'),
                                    content: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Dobra')),
                                          DataColumn(label: Text('Medida(%)'))
                                        ],
                                        rows: dobras.entries.map((e) {
                                          return DataRow(cells: [
                                            DataCell(Text(e.key)),
                                            DataCell(Text(e.value.toString()))
                                          ]);
                                        }).toList()),
                                  );
                                });
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('images/caliper.png'),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Dobras Cutâneas',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
