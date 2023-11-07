import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayanneandradepersonal/personal/tela_realizar_avaliacao.dart';

class Transicao extends StatefulWidget {
  const Transicao({super.key});

  @override
  State<Transicao> createState() => _TransicaoState();
}

class _TransicaoState extends State<Transicao> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> alunos = [];

  Future<void> getData() async {
    QuerySnapshot query = await firestore
        .collection('users')
        .where('role', isEqualTo: 'aluno')
        .get();
    setState(() {
      alunos =
          query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
          child: Center(
            child: Column(children: [
              Column(
                  children: alunos.map((aluno) {
                String nome = aluno['firstName'] + ' ' + aluno['lastName'];
                String nascimento = aluno['birthDay'];
                return Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(nome),
                        subtitle: Text(nascimento),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RealizarAvalicao('${aluno[
                                      "firstName"]} ${aluno["lastName"]}',
                                      aluno['email'], aluno['gender'], aluno['birthDay'])));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('images/user.png'),
                    )
                  ],
                );
              }).toList()),
            ]),
          ),
        ));
  }
}
