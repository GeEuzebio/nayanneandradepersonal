import 'package:flutter/material.dart';

class TelaCadastroTreino extends StatefulWidget {
  const TelaCadastroTreino({super.key});

  @override
  State<TelaCadastroTreino> createState() => _TelaCadastroTreinoState();
}

class _TelaCadastroTreinoState extends State<TelaCadastroTreino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }
}
