import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedefinirSenha extends StatefulWidget {
  const RedefinirSenha({super.key});

  @override
  State<RedefinirSenha> createState() => _RedefinirSenhaState();
}

class _RedefinirSenhaState extends State<RedefinirSenha> {
  String email = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Digite abaixo o email cadastrado na conta, caso esteja cadastrado em nosso banco de dados'),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (String e) {
                setState(() {
                  email = e;
                });
              },
              decoration: InputDecoration(
                  fillColor: Colors.pink.withOpacity(0.2),
                  filled: true,
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  )),
            ),
            ElevatedButton(
                onPressed: () async {
                  try{
                    await auth.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Email de redefinição de senha enviado!',
                            style: TextStyle(fontSize: 16),),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.green.shade200,
                        ));
                  } catch(e) {
                    if(e.toString().contains('user-not-found')){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Email não encontrado!',
                              style: TextStyle(fontSize: 16),),
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.red.shade200,
                          ));
                    }
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Enviar email de redefinição'))
          ],
        ),
      )
    );
  }
}
