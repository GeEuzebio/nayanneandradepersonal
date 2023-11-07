// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Map<String, dynamic> userData = {};

  Future<void> getData() async {
    QuerySnapshot query = await firestore
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    setState(() {
      userData = query.docs.first.data() as Map<String, dynamic>;
    });
  }

  String userId = '';

  Future<void> getId() async {
    QuerySnapshot query = await firestore
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    setState(() {
      userId = query.docs.first.id;
    });
  }

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController bloodType = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      firstName.text = userData['firstName'] ?? '';
      lastName.text = userData['lastName'] ?? '';
      email.text = userData['email'] ?? '';
      gender.text = userData['gender'] ?? 'M';
      birthDay.text = userData['birthDay'] ?? '';
      bloodType.text = userData['bloodType'] ?? 'A+';
      phone.text = userData['phone'] ?? '';
    });
    return Scaffold(
      //backgroundColor: Colors.white,
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
        title: const Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 190,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(
                          fillColor: Colors.pink.shade200.withOpacity(0.5),
                          filled: true,
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (String first) {
                        setState(() {
                          userData['firstName'] = first;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(
                          fillColor: Colors.pink.shade200.withOpacity(0.5),
                          filled: true,
                          labelText: 'Sobrenome',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (String last) {
                        setState(() {
                          userData['lastName'] = last;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      fillColor: Colors.pink.shade200.withOpacity(0.5),
                      filled: true,
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      )),
                  onChanged: (String e) {
                    setState(() {
                      userData['email'] = e;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 150,
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
                        value: gender.text,
                        items: const [
                          DropdownMenuItem(
                            value: 'M',
                            child: Text('Masculino'),
                          ),
                          DropdownMenuItem(
                            value: 'F',
                            child: Text('Feminino'),
                          ),
                          DropdownMenuItem(
                            value: 'O',
                            child: Text('Outros'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(
                            () {
                              userData['gender'] = value.toString();
                            },
                          );
                        }),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                        controller: birthDay,
                        inputFormatters: [MaskedInputFormatter('##/##/####')],
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            fillColor: Colors.pink.shade200.withOpacity(0.5),
                            filled: true,
                            labelText: 'Data de Nasc.',
                            labelStyle: TextStyle(color: Colors.grey.shade700),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            )),
                        onChanged: (String birth) {
                          setState(() {
                            userData['birthDay'] = birth;
                          });
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pink.shade200.withOpacity(0.5),
                    ),
                    child: DropdownButton(
                        alignment: Alignment.centerLeft,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        underline: const SizedBox.shrink(),
                        borderRadius: BorderRadius.circular(15),
                        value: bloodType.text,
                        items: const [
                          DropdownMenuItem(
                            value: 'A+',
                            child: Text('A+'),
                          ),
                          DropdownMenuItem(
                            value: 'A-',
                            child: Text('A-'),
                          ),
                          DropdownMenuItem(
                            value: 'B+',
                            child: Text('B+'),
                          ),
                          DropdownMenuItem(
                            value: 'B-',
                            child: Text('B-'),
                          ),
                          DropdownMenuItem(
                            value: 'AB+',
                            child: Text('AB+'),
                          ),
                          DropdownMenuItem(
                            value: 'AB-',
                            child: Text('AB-'),
                          ),
                          DropdownMenuItem(
                            value: 'O+',
                            child: Text('O+'),
                          ),
                          DropdownMenuItem(
                            value: 'O-',
                            child: Text('O-'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(
                            () {
                              userData['bloodType'] = value.toString();
                            },
                          );
                        }),
                  ),
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: phone,
                      inputFormatters: [
                        MaskedInputFormatter('(##) # ####-####')
                      ],
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          fillColor: Colors.pink.shade200.withOpacity(0.5),
                          filled: true,
                          labelText: 'Telefone',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (String p) {
                        setState(() {
                          userData['phone'] = p;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await firestore.collection('users').doc(userId).update({
                      'firstName': userData['firstName'],
                      'lastName': userData['lastName'],
                      'email': userData['email'],
                      'gender': userData['gender'],
                      'birthDay': userData['birthDay'],
                      'bloodType': userData['bloodType'],
                      'phone': userData['phone'],
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        'Dados atualizados com sucesso!',
                        style: TextStyle(fontSize: 16),
                      ),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.green.shade200,
                    ));
                  } catch (e) {
                    if (e.toString().isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          'Erro ao atualizar os dados!',
                          style: TextStyle(fontSize: 16),
                        ),
                        duration: const Duration(seconds: 3),
                        backgroundColor: Colors.red.shade200,
                      ));
                    }
                  }
                },
                child: const Text('Atualizar Perfil'))
          ],
        ),
      ),
    );
  }
}
