import 'package:flutter/material.dart';

class InformacoesAluno extends StatefulWidget {
  const InformacoesAluno({super.key});

  @override
  State<InformacoesAluno> createState() => _InformacoesAlunoState();
}

class _InformacoesAlunoState extends State<InformacoesAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: const Column(),
    );
  }
}
