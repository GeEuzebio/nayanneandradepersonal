// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nayanneandradepersonal/controlers/pdf_controlers/pdf_avaliacao.dart';

class RealizarAvalicao extends StatefulWidget {
  final String nome;
  final String email;
  final String gender;
  final String birthDay;

  const RealizarAvalicao(this.nome, this.email, this.gender, this.birthDay,
      {super.key});

  @override
  State<RealizarAvalicao> createState() => _RealizarAvalicaoState();
}

class _RealizarAvalicaoState extends State<RealizarAvalicao> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  String pollock = '';
  Map<String, double> perimetrias = {
    'pescoco': 0,
    'peitoral': 0,
    'bicE': 0,
    'bicD': 0,
    'antE': 0,
    'antD': 0,
    'cintura': 0,
    'quadril': 0,
    'coxaE': 0,
    'coxaD': 0,
    'pantE': 0,
    'pantD': 0
  };
  Map<String, double> dobras = {
    'dobraPeitoral': 0,
    'axial': 0,
    'subscapular': 0,
    'triciptal': 0,
    'suprailiaca': 0,
    'abdominal': 0,
    'coxal': 0,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Perimetrias'),
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'images/avaliacao.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 100, bottom: 30, right: 100),
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                hintText: 'Pescoço',
                                hintStyle: const TextStyle(color: Colors.pink),
                                // border: const OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                              onChanged: (value) {
                                setState(() {
                                  perimetrias['pescoco'] = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                hintText: 'Peitoral',
                                hintStyle: const TextStyle(color: Colors.pink),
                                // border: const OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                              onChanged: (value) {
                                setState(() {
                                  perimetrias['peitoral'] = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Bíceps esq.',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['bicE'] = double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Bíceps dir.',
                                    hintStyle: const TextStyle(
                                      color: Colors.pink,
                                    ),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['bicD'] = double.parse(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      fillColor: Colors.pink.withOpacity(0.2),
                                      filled: false,
                                      hintText: 'Ant. esq.',
                                      hintStyle:
                                          const TextStyle(color: Colors.pink),
                                      // border: const OutlineInputBorder(
                                      //   borderRadius:
                                      //       BorderRadius.all(Radius.circular(10)),
                                      //   borderSide: BorderSide.none,
                                      // )
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        perimetrias['antE'] =
                                            double.parse(value);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      fillColor: Colors.pink.withOpacity(0.2),
                                      filled: false,
                                      hintText: 'Ant. dir.',
                                      hintStyle:
                                          const TextStyle(color: Colors.pink),
                                      // border: const OutlineInputBorder(
                                      //   borderRadius:
                                      //       BorderRadius.all(Radius.circular(10)),
                                      //   borderSide: BorderSide.none,
                                      // )
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        perimetrias['antD'] =
                                            double.parse(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Cintura',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['cintura'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Quadril',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['quadril'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Coxa esq.',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['coxaE'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Coxa dir.',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['coxaD'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Pant. esq.',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['pantE'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    fillColor: Colors.pink.withOpacity(0.2),
                                    filled: false,
                                    hintText: 'Pant. dir.',
                                    hintStyle:
                                        const TextStyle(color: Colors.pink),
                                    // border: const OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.all(Radius.circular(10)),
                                    //   borderSide: BorderSide.none,
                                    // )
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      perimetrias['pantD'] =
                                          double.parse(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pollock = '3';
                          });
                        },
                        child: const Text('Pollock 3 dobras')),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pollock = '7';
                          });
                        },
                        child: const Text('Pollock 7 dobras'))
                  ],
                ),
                SizedBox(
                  child: CarouselSlider(
                      items: [
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'images/pollock_test_front.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 160),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100,
                                          child: (pollock == '7' ||
                                                  (pollock == '3' &&
                                                      widget.gender == 'M'))
                                              ? TextFormField(
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dobras['dobraPeitoral'] =
                                                          double.parse(value);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.pink
                                                          .withOpacity(0.2),
                                                      filled: false,
                                                      hintText: 'Peitoral',
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.pink)),
                                                )
                                              : const SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 90,
                                          child: pollock == '7'
                                              ? TextFormField(
                                                  textAlign: TextAlign.right,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dobras['axial'] =
                                                          double.parse(value);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.pink
                                                          .withOpacity(0.2),
                                                      filled: false,
                                                      hintText: 'Axial',
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.pink)),
                                                )
                                              : const SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 115),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 100,
                                          child: pollock == '7'
                                              ? TextFormField(
                                                  textAlign: TextAlign.left,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dobras['suprailiaca'] =
                                                          double.parse(value);
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      fillColor: Colors.pink
                                                          .withOpacity(0.2),
                                                      filled: false,
                                                      hintText: 'Suprailíaca',
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.pink)),
                                                )
                                              : const SizedBox(),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            textAlign: TextAlign.right,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                dobras['abdominal'] =
                                                    double.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                fillColor: Colors.pink
                                                    .withOpacity(0.2),
                                                filled: false,
                                                hintText: 'Abdominal',
                                                hintStyle: const TextStyle(
                                                    color: Colors.pink)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 70),
                                        child: SizedBox(
                                          width: 90,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                dobras['coxal'] =
                                                    double.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                fillColor: Colors.pink
                                                    .withOpacity(0.2),
                                                filled: false,
                                                hintText: 'Coxal',
                                                hintStyle: const TextStyle(
                                                    color: Colors.pink)),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Opacity(
                                opacity: 0.3,
                                child: Image.asset(
                                  'images/pollock_test_back.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 170),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    child: pollock == '7'
                                        ? TextFormField(
                                            textAlign: TextAlign.left,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                dobras['subscapular'] =
                                                    double.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                fillColor: Colors.pink
                                                    .withOpacity(0.2),
                                                filled: false,
                                                hintText: 'Subscapular',
                                                hintStyle: const TextStyle(
                                                    color: Colors.pink)),
                                          )
                                        : const SizedBox(),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: (pollock == '7' ||
                                              (pollock == '3' &&
                                                  widget.gender == 'F'))
                                          ? TextFormField(
                                              textAlign: TextAlign.right,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  dobras['triciptal'] =
                                                      double.parse(value);
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  fillColor: Colors.pink
                                                      .withOpacity(0.2),
                                                  filled: false,
                                                  hintText: 'Triciptal',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.pink)),
                                            )
                                          : const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      options: CarouselOptions(
                          viewportFraction: 0.8,
                          aspectRatio: 0.5,
                          enableInfiniteScroll: false)),
                ),
                // ElevatedButton(
                //     onPressed: () async {},
                //     child: const Text('Realizar Avaliação')),
                AvaliacaoPDF(
                  nome: widget.nome,
                  gender: widget.gender,
                  birthDay: widget.birthDay,
                  email: widget.email,
                  perimetrias: perimetrias,
                  dobras: dobras,
                )
              ],
            )));
  }
}
