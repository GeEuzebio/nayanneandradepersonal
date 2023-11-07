// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:nayanneandradepersonal/controlers/firebase_controlers.dart';
import 'package:nayanneandradepersonal/personal/tela_personal_principal.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  bool isSelected = false;
  String sexoAluno1 = 'Masculino';
  String nomeAluno1 = '';
  String sobrenomeAluno1 = '';
  String nascimentoAluno1 = '';
  String emailAluno1 = '';
  String telefoneAluno1 = '';
  String sexoAluno2 = 'Masculino';
  String nomeAluno2 = '';
  String sobrenomeAluno2 = '';
  String nascimentoAluno2 = '';
  String emailAluno2 = '';
  String telefoneAluno2 = '';
  List<bool> daysOfTraining = [false, false, false, false, false, false, false];
  List<bool> isPicked = [false, false, false, false, false, false, false];
  List<String> typeOfTraining = [
    'Single',
    'Couple',
    'Senior Single',
    'Senior Couple'
  ];
  Map<int, String> daysOfWeek = {
    DateTime.monday: 'Segunda-feira',
    DateTime.tuesday: 'Terça-feira',
    DateTime.wednesday: 'Quarta-feira',
    DateTime.thursday: 'Quinta-feira',
    DateTime.friday: 'Sexta-feira',
    DateTime.saturday: 'Sábado',
    DateTime.sunday: 'Domingo'
  };

  List<TimeOfDay> hoursOfTraining = [
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now(),
    TimeOfDay.now()
  ];
  List<String> valuesOfTraining = [
    'Single',
    'Single',
    'Single',
    'Single',
    'Single',
    'Single',
    'Single'
  ];
  String typeOfStudent = 'Single';
  String password1 = '';
  String password2 = '';
  Color buttonSingle = Colors.pink;
  Color buttonCouple = Colors.pink.shade200;

  @override
  Widget build(BuildContext context) {
    List<String> days = daysOfWeek.values.toList();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Center(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Formulário Básico de Cadastro de Aluno(s)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text('Selecione o tipo de aluno:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            typeOfStudent = 'Single';
                            buttonSingle = Colors.pink;
                            buttonCouple = Colors.pink.shade200;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonSingle,
                            minimumSize: const Size(60, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/single.png'),
                            const Text('Single')
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            typeOfStudent = 'Couple';
                            buttonSingle = Colors.pink.shade200;
                            buttonCouple = Colors.pink;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonCouple,
                            minimumSize: const Size(60, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/couple.png'),
                            const Text('Couple')
                          ],
                        )),
                  ],
                ),
                Text(typeOfStudent == 'Single'
                    ? 'Dados Pessoais'
                    : 'Dados Pessoais do Primeiro Aluno'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    onChanged: (String name) {
                      setState(() {
                        nomeAluno1 = name;
                      });
                    },
                    decoration: const InputDecoration(
                      // fillColor: Colors.white,
                      filled: false,
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.black),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   borderSide: BorderSide.none,
                      // )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    onChanged: (String lastName) {
                      setState(() {
                        sobrenomeAluno1 = lastName;
                      });
                    },
                    decoration: const InputDecoration(
                      // fillColor: Colors.pink.withOpacity(0.2),
                      filled: false,
                      labelText: 'Sobrenome',
                      labelStyle: TextStyle(color: Colors.black),
                      // border: const OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   borderSide: BorderSide.none,
                      // )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton(
                          alignment: Alignment.centerLeft,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          underline: const SizedBox.shrink(),
                          borderRadius: BorderRadius.circular(15),
                          value: sexoAluno1,
                          items: const [
                            DropdownMenuItem(
                              value: 'Masculino',
                              child: Text('Masculino'),
                            ),
                            DropdownMenuItem(
                              value: 'Feminino',
                              child: Text('Feminino'),
                            ),
                            DropdownMenuItem(
                              value: 'Outros',
                              child: Text('Outros'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(
                              () {
                                sexoAluno1 = value!;
                              },
                            );
                          }),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          inputFormatters: [MaskedInputFormatter('##/##/####')],
                          keyboardType: TextInputType.datetime,
                          onChanged: (String birthday) {
                            setState(() {
                              nascimentoAluno1 = birthday.toString();
                              password1 = birthday.splitMapJoin(
                                '/',
                                onMatch: (match) => '',
                                onNonMatch: (nonMatch) => nonMatch,
                              );
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'dd/mm/aaaa',
                            fillColor: Colors.pink.withOpacity(0.2),
                            filled: false,
                            labelText: 'Data de Nasc.',
                            labelStyle: const TextStyle(color: Colors.black),
                            // border: const OutlineInputBorder(
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(10)),
                            //   borderSide: BorderSide.none,
                            // )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (String e) {
                      setState(() {
                        emailAluno1 = e;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.pink.withOpacity(0.2),
                      filled: false,
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.black),
                      // border: const OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   borderSide: BorderSide.none,
                      // )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    inputFormatters: [MaskedInputFormatter('(##) # ####-####')],
                    onChanged: (String phone) {
                      setState(() {
                        telefoneAluno1 = phone;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: Colors.pink.withOpacity(0.2),
                      filled: false,
                      labelText: 'Telefone/Whatsapp',
                      labelStyle: const TextStyle(color: Colors.black),
                      // border: const OutlineInputBorder(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      //   borderSide: BorderSide.none,
                      // )
                    ),
                  ),
                ),
                typeOfStudent == 'Couple'
                    ? Column(
                        children: <Widget>[
                          const Text('Dados Pessoais do Segundo Aluno'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              onChanged: (String name) {
                                setState(() {
                                  nomeAluno2 = name;
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                labelText: 'Nome',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                // border: const OutlineInputBorder(
                                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              onChanged: (String lastName) {
                                setState(() {
                                  sobrenomeAluno2 = lastName;
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                labelText: 'Sobrenome',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                // border: const OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 150,
                                  alignment: Alignment.center,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(15),
                                  //   color: Colors.pink.withOpacity(0.2),
                                  // ),
                                  child: DropdownButton(
                                      alignment: Alignment.centerLeft,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      underline: const SizedBox.shrink(),
                                      borderRadius: BorderRadius.circular(15),
                                      value: sexoAluno2,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Masculino',
                                          child: Text('Masculino'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Feminino',
                                          child: Text('Feminino'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Outros',
                                          child: Text('Outros'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            sexoAluno2 = value!;
                                          },
                                        );
                                      }),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    inputFormatters: [
                                      MaskedInputFormatter('##/##/####')
                                    ],
                                    keyboardType: TextInputType.datetime,
                                    onChanged: (String birthday) {
                                      setState(() {
                                        nascimentoAluno2 = birthday.toString();
                                        password2 = birthday.splitMapJoin(
                                          '/',
                                          onMatch: (match) => '',
                                          onNonMatch: (nonMatch) => nonMatch,
                                        );
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'dd/mm/aaaa',
                                      fillColor: Colors.pink.withOpacity(0.2),
                                      filled: false,
                                      labelText: 'Data de Nasc.',
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      // border: const OutlineInputBorder(
                                      //   borderRadius: BorderRadius.all(
                                      //       Radius.circular(10)),
                                      //   borderSide: BorderSide.none,
                                      // )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (String e) {
                                setState(() {
                                  emailAluno2 = e;
                                });
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                labelText: 'Email',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                // border: const OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              inputFormatters: [
                                MaskedInputFormatter('(##) # ####-####')
                              ],
                              onChanged: (String phone) {
                                setState(() {
                                  telefoneAluno2 = phone;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                fillColor: Colors.pink.withOpacity(0.2),
                                filled: false,
                                labelText: 'Telefone/Whatsapp',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                // border: const OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10)),
                                //   borderSide: BorderSide.none,
                                // )
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const Text('Dados do Treino'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Dias de Treino',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: daysOfWeek.entries.map((day) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: daysOfTraining[day.key - 1]
                                  ? Colors.pink
                                  : Colors.pink.shade200,
                              minimumSize: const Size(40, 40),
                              maximumSize: const Size(60, 60),
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.symmetric()),
                          onPressed: () {
                            setState(() {
                              daysOfTraining[day.key - 1] =
                                  !daysOfTraining[day.key - 1];
                            });
                          },
                          child: Text(day.value.substring(0, 3)),
                        );
                      }).toList(),
                    ),
                    Column(
                      children: daysOfTraining.asMap().entries.map((e) {
                        int index = e.key;
                        bool isTraining = e.value;
                        if (isTraining) {
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Tipo de aula',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  DropdownButton(
                                    alignment: Alignment.centerLeft,
                                    elevation: 2,
                                    menuMaxHeight: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    underline: const SizedBox.shrink(),
                                    borderRadius: BorderRadius.circular(5),
                                    value: valuesOfTraining[index],
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Single',
                                        child: Text('Single'),
                                      ),
                                      DropdownMenuItem(
                                          value: 'Couple',
                                          child: Text('Couple'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        valuesOfTraining[index] =
                                            value.toString();
                                      });
                                    },
                                  )
                                ],
                              ),
                              subtitle: Text(days[index]),
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
                                      hoursOfTraining[index] = pick!;
                                      isPicked[index] = true;
                                    });
                                  },
                                  child: isPicked[index]
                                      ? Text(hoursOfTraining[index]
                                          .format(context))
                                      : Text('Selecione o horário'),
                                ),
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            hoursOfTraining[index] =
                                TimeOfDay(hour: 0, minute: 0);
                            valuesOfTraining[index] = 'Single';
                          });
                          return const SizedBox();
                        }
                      }).toList(),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        typeOfStudent == 'Single'
                            ? registerSingleStudent(
                                password1,
                                nomeAluno1,
                                sobrenomeAluno1,
                                sexoAluno1,
                                nascimentoAluno1,
                                emailAluno1,
                                telefoneAluno1,
                                typeOfStudent,
                                daysOfTraining,
                                hoursOfTraining,
                                valuesOfTraining)
                            : registerCoupleStudents(
                                password1,
                                password2,
                                nomeAluno1,
                                sobrenomeAluno1,
                                sexoAluno1,
                                nascimentoAluno1,
                                emailAluno1,
                                telefoneAluno1,
                                nomeAluno2,
                                sobrenomeAluno2,
                                sexoAluno2,
                                nascimentoAluno2,
                                emailAluno2,
                                telefoneAluno2,
                                typeOfStudent,
                                daysOfTraining,
                                hoursOfTraining,
                                valuesOfTraining);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TelaPersonal()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'Aluno(s) cadastrado(s) com sucesso!',
                            style: TextStyle(fontSize: 16),
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.green.shade200,
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'Erro ao cadastrar aluno(s)!',
                            style: TextStyle(fontSize: 16),
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red.shade200,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade200,
                        minimumSize: const Size(200, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      'Cadastrar Aluno',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
