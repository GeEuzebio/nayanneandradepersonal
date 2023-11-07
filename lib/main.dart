// ignore_for_file: file_names, depend_on_referenced_packages
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nayanneandradepersonal/aluno/tela_aluno_principal.dart';
import 'package:nayanneandradepersonal/personal/tela_personal_principal.dart';
import 'package:nayanneandradepersonal/tela_login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    [
      Permission.storage
    ].request().then((status) {
      runApp(const Login());
    });

  } else {
    runApp(const Login());
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn() {
      final user = auth.currentUser;
      return user != null;
    }

    Future<bool> isPersonal() async {
      final querySnapshot = await firestore.collection('users').get();
      var doc = querySnapshot.docs
          .firstWhere((element) => element['email'] == auth.currentUser!.email);
      if (doc['email'] == auth.currentUser?.email) {
        return doc['role'] == 'personal';
      }
      return false;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: isUserLoggedIn() ? isPersonal() : Future.value(false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Erro ao verificar papel do usuário');
          } else {
            final bool isPersonalUser = snapshot.data ?? false;
            return isUserLoggedIn()
                ? (isPersonalUser ? const TelaPersonal() : const TelaAluno())
                : const TelaLogin();
          }
        },
      ),
    );
  }
}
