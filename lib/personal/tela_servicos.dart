import 'package:flutter/material.dart';
import 'package:nayanneandradepersonal/personal/tela_transicao_cadastro_treino.dart';
import 'package:nayanneandradepersonal/personal/tela_transicao_avaliacao.dart';
import 'package:nayanneandradepersonal/personal/tela_transicao_pagamentos.dart';
import 'package:nayanneandradepersonal/personal/tela_transicao_remarcacao_aula.dart';

class TelaServicos extends StatefulWidget {
  const TelaServicos({super.key});

  @override
  State<TelaServicos> createState() => _TelaServicosState();
}

class _TelaServicosState extends State<TelaServicos> {
  @override
  Widget build(BuildContext context) {
    Map<Widget, List<String>> telas = {
      const TransicaoCadastrarTreino() : ['Prescrever Treino', 'images/document.png'],
      const Transicao(): ['Realizar Avaliação', 'images/caliper.png'],
      const TransicaoRemarcacao(): ['Agendar Aulas', 'images/schedule.png'],
      const TransicaoPagamentos(): ['Financeiro', 'images/money.png']
    };
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Wrap(
              alignment: WrapAlignment.start,
              children: telas.entries.map((e){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => e.key
                        )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.pink.shade200,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 0))
                        ]
                        ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(e.value[1]),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                              child: Text(e.value[0],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),
                            )
                          ],
                        ),
                      )
                      ),
                    ),
                  );
              }).toList()
          )
        ],
      ),
    );
  }
}
