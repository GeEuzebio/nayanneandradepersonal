import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nayanneandradepersonal/aluno/tela_aluno_principal.dart';
import 'package:nayanneandradepersonal/tela_redefinir_senha.dart';
import 'package:nayanneandradepersonal/personal/tela_personal_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String alert = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 300,
                  child: Image.asset('images/logo.png'),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .moveY(duration: 1000.ms, begin: 0, end: -25)
                    .scaleXY(begin: 1, end: 1.2)
                    .then()
                    .moveY(begin: -25, end: 0)
                    .scaleXY(begin: 1.2, end: 1)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    )),
                onChanged: (String e) {
                  setState(() {
                    email = e;
                  });
                },
              ),
            ),
            Text(alert),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    )),
                onChanged: (String e) {
                  setState(() {
                    password = e;
                  });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade100, elevation: 2),
                    onPressed: () async {
                      try {
                        await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (!auth.currentUser!.emailVerified) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              'Email não verificado. Reenviamos o email de verificação, por favor verifique sua caixa de entrada ou spam.',
                              style: TextStyle(fontSize: 16),
                            ),
                            duration: const Duration(seconds: 5),
                            backgroundColor: Colors.yellow.shade700,
                            onVisible: () async {
                              await auth.currentUser!.sendEmailVerification();
                            },
                          ));
                        }
                        await firestore
                            .collection('users')
                            .get()
                            .then((QuerySnapshot query) {
                          auth.authStateChanges().listen((User? user) {
                            for (var doc in query.docs) {
                              if (user != null &&
                                  doc['role'] == 'aluno' &&
                                  doc['email'] == email &&
                                  auth.currentUser!.emailVerified) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TelaAluno()));
                              } else if (user != null &&
                                  doc['role'] == 'personal' &&
                                  doc['email'] == email &&
                                  auth.currentUser!.emailVerified) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TelaPersonal()));
                              }
                            }
                          });
                        });
                      } catch (e) {
                        if (e.toString().contains('user-not-found') ||
                            e.toString().contains('wrong-password')) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                              'Email ou senha incorreto(s)!',
                              style: TextStyle(fontSize: 16),
                            ),
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.red.shade200,
                          ));
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RedefinirSenha()));
                },
                child: const Text('Esqueceu a senha?'))
          ],
        ),
      ),
    );
  }
}
