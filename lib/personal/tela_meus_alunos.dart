import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nayanneandradepersonal/personal/tela_cadastro_aluno.dart';
import 'package:nayanneandradepersonal/personal/tela_informacoes_aluno.dart';

class MeusAlunos extends StatefulWidget {
  const MeusAlunos({super.key});

  @override
  State<MeusAlunos> createState() => _MeusAlunosState();
}

class _MeusAlunosState extends State<MeusAlunos> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> alunos = [];
  Future<void> getData() async {
    QuerySnapshot query = await firestore
        .collection('users')
        .where('role', isEqualTo: 'aluno')
        .get();
    setState(() {
      alunos = query.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InformacoesAluno()
                            )
                        );
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
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50), shape: const CircleBorder()),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TelaCadastro()));
              },
              child: const Icon(Icons.add)),
        ),
      ]),
    );
  }
}
