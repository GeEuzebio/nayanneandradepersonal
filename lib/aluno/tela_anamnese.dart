import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaAnamnese extends StatefulWidget {
  const TelaAnamnese({super.key});

  @override
  State<TelaAnamnese> createState() => _TelaAnamneseState();
}

class _TelaAnamneseState extends State<TelaAnamnese> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> userData = {};

  Future<void> getData() async {
    QuerySnapshot query = await firestore
        .collection('anamnese')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    setState(() {
      userData = query.docs.first.data() as Map<String, dynamic>;
    });
  }

  String userId = '';

  Future<void> getId() async {
    QuerySnapshot query = await firestore
        .collection('anamnese')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    setState(() {
      userId = query.docs.first.id;
    });
  }

  String objetivo = ' ';
  String exercicio = '';
  String fuma = '';
  String bebe = '';
  String colesterol = '';
  String diabetes = '';
  String dores = '';
  String disfuncao = '';
  String patologia = '';
  String limitacao = '';
  String cirurgia = '';
  String remedio = '';
  bool respondida = false;

  @override
  void initState() {
    super.initState();
    getData();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      respondida = userData['answered'] ?? false;
      objetivo = userData['objective'] ?? 'Emagrecimento';
      exercicio = userData['exercise'] ?? '';
      fuma = userData['smoke'] ?? '';
      bebe = userData['drink'] ?? '';
      colesterol = userData['cholesterol'] ?? '';
      diabetes = userData['diabetes'] ?? '';
      dores = userData['pain'] ?? '';
      disfuncao = userData['dysfunction'] ?? '';
      patologia = userData['pathology'] ?? '';
      limitacao = userData['limitation'] ?? '';
      cirurgia = userData['surgery'] ?? '';
      remedio = userData['medicine'] ?? '';
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: const Text('Ficha de Anamnese'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text('Objetivo do treino: '),
                      Container(
                        height: 60,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.pink.shade200.withOpacity(0.5),
                        ),
                        child: DropdownButton(
                            alignment: Alignment.centerLeft,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            underline: const SizedBox.shrink(),
                            borderRadius: BorderRadius.circular(15),
                            value: objetivo,
                            items: [
                              DropdownMenuItem(
                                enabled: !respondida,
                                value: ' ',
                                child: const Text(' '),
                              ),
                              DropdownMenuItem(
                                enabled: !respondida,
                                value: 'Emagrecimento',
                                child: const Text('Emagrecimento'),
                              ),
                              DropdownMenuItem(
                                enabled: !respondida,
                                value: 'Hipertrofia',
                                child: const Text('Hipertrofia'),
                              ),
                              DropdownMenuItem(
                                enabled: !respondida,
                                value: 'Condicionamento',
                                child: const Text('Condicionamento'),
                              ),
                              DropdownMenuItem(
                                enabled: !respondida,
                                value: 'Outros',
                                child: const Text('Outros'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(
                                () {
                                  userData['objective'] = value.toString();
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                  (objetivo == 'Outros')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['objectiveMotivation']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Quais?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['objectiveMotivation'] = value;
                                  }
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Já praticou exercício?'),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: exercicio,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['exercise'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: exercicio,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['exercise'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (exercicio == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['exercisePeriod']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual e por quanto tempo?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['exercisePeriod'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                        readOnly: respondida,
                        controller:
                            TextEditingController(text: userData['period']),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            fillColor: Colors.pink.shade200.withOpacity(0.5),
                            filled: true,
                            labelText:
                                'Há quanto tempo está sem fazer exercícios?',
                            labelStyle: TextStyle(color: Colors.grey.shade700),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            )),
                        onChanged: (String value) {
                          setState(() {
                            userData['period'] = value;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('É fumante?'),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Sim'),
                            value: 'sim',
                            groupValue: fuma,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['smoke'] = value.toString();
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Não'),
                            value: 'não',
                            groupValue: fuma,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['smoke'] = value.toString();
                                }
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Ingere bebida alcólica?'),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Sim'),
                            value: 'sim',
                            groupValue: bebe,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['drink'] = value.toString();
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Não'),
                            value: 'não',
                            groupValue: bebe,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['drink'] = value.toString();
                                }
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Tem colesterol \nelevado?'),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Sim'),
                            value: 'sim',
                            groupValue: colesterol,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['cholesterol'] = value.toString();
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Não'),
                            value: 'não',
                            groupValue: colesterol,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['cholesterol'] = value.toString();
                                }
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Tem diabetes?'),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Sim'),
                            value: 'sim',
                            groupValue: diabetes,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['diabetes'] = value.toString();
                                }
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text('Não'),
                            value: 'não',
                            groupValue: diabetes,
                            onChanged: (value) {
                              setState(() {
                                if (!respondida) {
                                  userData['diabetes'] = value.toString();
                                }
                              });
                            }),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Sente dores \narticulares?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: dores,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['pain'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: dores,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['pain'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (dores == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['painSpot']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Onde?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['painSpot'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Possui disfunção \nortopédica?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: disfuncao,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['dysfunction'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: disfuncao,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['dysfunction'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (disfuncao == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['ortoDysfunction']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['ortoDysfunction'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Apresenta alguma \npatologia?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: patologia,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['pathology'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: patologia,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['pathology'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (patologia == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['pathologyDescription']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['pathologyDescription'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Apresenta limitação \ndos movimentos?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: limitacao,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['limitation'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: limitacao,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['limitation'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (limitacao == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['limitationDescription']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['limitationDescription'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Passou por alguma \ncirurgia?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: cirurgia,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['surgery'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: cirurgia,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['surgery'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (cirurgia == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['surgeryDescription']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['surgeryDescription'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(children: <Widget>[
                        const Text('Usa de medicamento\ncontrolado?'),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Sim'),
                              value: 'sim',
                              groupValue: remedio,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['medicine'] = value.toString();
                                  }
                                });
                              }),
                        ),
                        Flexible(
                          child: RadioListTile(
                              title: const Text('Não'),
                              value: 'não',
                              groupValue: remedio,
                              onChanged: (value) {
                                setState(() {
                                  if (!respondida) {
                                    userData['medicine'] = value.toString();
                                  }
                                });
                              }),
                        ),
                      ])),
                  (remedio == 'sim')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                              readOnly: respondida,
                              controller: TextEditingController(
                                  text: userData['medicineDescription']),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  fillColor:
                                      Colors.pink.shade200.withOpacity(0.5),
                                  filled: true,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide.none,
                                  )),
                              onChanged: (String value) {
                                setState(() {
                                  userData['medicineDescription'] = value;
                                });
                              }),
                        )
                      : const SizedBox(),
                  !respondida
                      ? ElevatedButton(
                          onPressed: () async {
                            try {
                              await firestore
                                  .collection('anamnese')
                                  .doc(userId)
                                  .update({
                                'answered': !userData['answered'],
                                'objective': userData['objective'],
                                'objectiveMotivation':
                                    userData['objectiveMotivation'],
                                'exercise': userData['exercise'],
                                'exercisePeriod': userData['exercisePeriod'],
                                'period': userData['period'],
                                'smoke': userData['smoke'],
                                'drink': userData['drink'],
                                'cholesterol': userData['cholesterol'],
                                'diabetes': userData['diabetes'],
                                'pain': userData['pain'],
                                'painSpot': userData['painSpot'],
                                'dysfunction': userData['dysfunction'],
                                'ortoDysfunction': userData['ortoDysfunction'],
                                'pathology': userData['pathology'],
                                'pathologyDescription':
                                    userData['pathologyDescription'],
                                'limitation': userData['limitation'],
                                'limitationDescription':
                                    userData['limitationDescription'],
                                'surgery': userData['surgery'],
                                'surgeryDescription':
                                    userData['surgeryDescription'],
                                'medicine': userData['medicine'],
                                'medicineDescription':
                                    userData['medicineDescription']
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  'Questionário respondido com sucesso!',
                                  style: TextStyle(fontSize: 16),
                                ),
                                duration: const Duration(seconds: 3),
                                backgroundColor: Colors.green.shade200,
                              ));
                            } catch (e) {
                              if (e.toString().isNotEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    'Erro ao responder questionário!',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red.shade200,
                                ));
                              }
                            }
                          },
                          child: const Text('Responder Questionário'))
                      : const SizedBox()
                ],
              )
              //   : Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text('Objetivo do treino: ${userData['objective']}',
              //           style: const TextStyle(
              //           fontSize: 18
              //         ),),
              //         userData['objectiveMotivation'] == ''
              //             ? const SizedBox()
              //             : Text('Quais?\n${userData['objectiveMotivation']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('Já praticou exercício? ${userData['exercise']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['exercisePeriod'] == ''
              //             ? const SizedBox()
              //             : Text(
              //                 'Qual e por quanto tempo?\n${userData['exercisePeriod']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text(
              //             'Há quanto tempo está sem fazer exercício?\n${userData['period']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('É fumante?\n${userData['smoke']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('Ingere bebida alcólica?\n${userData['drink']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('Tem colesterol elevado?\n${userData['cholesterol']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('Tem diabetes?\n${userData['diabetes']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         Text('Sente dores articulares? ${userData['pain']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['pain'] == 'Sim'
              //             ? Text('Onde?\n${userData['painSpot']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //         Text(
              //             'Possui disfunção ortopédica? ${userData['dysfunction']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['dysfunction'] == 'Sim'
              //             ? Text('Qual?\n${userData['ortoDysfunction']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //         Text('Apresenta alguma patologia? ${userData['pathology']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['pathology'] == 'Sim'
              //             ? Text('Qual?\n${userData['pathologyDescription']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //         Text('Apresenta alguma limitação? ${userData['limitation']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['limitation'] == 'Sim'
              //             ? Text('Qual?\n${userData['limitationDescription']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //         Text('Passou por alguma cirurgia? ${userData['surgery']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['surgery'] == 'Sim'
              //             ? Text('Qual?\n${userData['surgeryDescription']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //         Text('Faz uso de medicamento controlado? ${userData['medicine']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),),
              //         userData['medicine'] == 'Sim'
              //             ? Text('Qual?\n${userData['medicineDescription']}',
              //           style: const TextStyle(
              //               fontSize: 18
              //           ),)
              //             : const SizedBox(),
              //       ],
              //     ),
              )),
    );
  }
}
