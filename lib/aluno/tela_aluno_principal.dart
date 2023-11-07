// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nayanneandradepersonal/aluno/tela_anamnese.dart';
import 'package:nayanneandradepersonal/aluno/tela_avaliacao.dart';
import 'package:nayanneandradepersonal/aluno/tela_calendarioAula.dart';
import 'package:nayanneandradepersonal/aluno/tela_editar_perfil.dart';
import 'package:nayanneandradepersonal/aluno/tela_treino_diario.dart';

import '../tela_login.dart';

class TelaAluno extends StatelessWidget {
  const TelaAluno({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 1;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Map<String, dynamic> usuario = {};
  Future<void> dadosPessoais() async {
    QuerySnapshot query = await firestore.collection('users').where('email', isEqualTo: auth.currentUser!.email).get();
    setState(() {
      usuario = query.docs.first.data() as Map<String, dynamic>;
    });
  }
  String avatarUrl =
      'https://firebasestorage.googleapis.com/v0/b/naypersonal.appspot.com/o/user.png?alt=media&token=7775cc51-28ee-4e66-bea3-ba88e131f263';
  final ImagePicker picker = ImagePicker();
  String imageProfile = '';
  Future<String> getImageProfile() async {
    if (auth.currentUser == null) {
      return avatarUrl;
    }
    return await storage
        .ref()
        .child('profile_images/${auth.currentUser!.email}')
        .getDownloadURL();
  }

  Future<void> uploadImageToStorage(File imageFile) async {
    try {
      if (auth.currentUser == null) {
        return;
      }
      Reference storageRef =
      storage.ref().child('profile_images/${auth.currentUser!.email}');

      await storageRef.putFile(imageFile);
      setState(() {});
    } catch (e) {
      if (e.toString().contains('Too many attempts')) {
        Future.delayed(const Duration(seconds: 3));
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    final photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    }
    final imageTemporary = File(photo.path);
    uploadImageToStorage(imageTemporary);
  }
  @override
  void initState() {
    super.initState();
    dadosPessoais();
  }
  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = <Widget>[
      CalendarioAulas(),
      TreinoDiario(),
      Avaliacao()
    ];

    void onTappedIcon(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Builder(
              builder: (ctx) => IconButton(
                  onPressed: () {
                    Scaffold.of(ctx).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 245),
                      child: Builder(
                          builder: (ctx) => IconButton(
                              onPressed: () async {
                                try{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const TelaLogin())
                                  );
                                  await auth.signOut();
                                } catch (e) {
                                  throw Exception(e);
                                }
                              },
                              icon: const Icon(Icons.logout))),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) => Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Gallery'),
                                      onTap: pickImageFromGallery,
                                    ),
                                  ],
                                ));
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: <Widget>[
                              FutureBuilder(
                                future: getImageProfile(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return CircleAvatar(
                                      radius: 42,
                                      backgroundImage:
                                      NetworkImage(snapshot.data.toString()),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Colors.black.withOpacity(0.5)
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${usuario['firstName']} ${usuario['lastName']}"),
                            Text("${usuario['bloodType']} 🩸"),
                            Text(usuario['gender'].toString())
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.book),
                    title: const Text("Histórico de Avaliações"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.stethoscope),
                    title: const Text("Ficha de Anamnese"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TelaAnamnese()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.calendar),
                    title: const Text("Remarcações de Aula"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.person),
                    title: const Text("Editar Perfil"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditarPerfil()));
                    },
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Nayanne Andrade Personal Trainer®',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: pages.elementAt(currentIndex),
            )),
        bottomNavigationBar: CurvedNavigationBar(
            index: currentIndex,
            onTap: onTappedIcon,
            color: Colors.pink.shade100,
            backgroundColor: Colors.white,
            buttonBackgroundColor: Colors.blueAccent,
            items: [
              Image.asset(
                'images/calendar.png',
                width: 40,
              ),
              Image.asset(
                'images/dumbell.png',
                width: 40,
              ),
              Image.asset(
                'images/checklist.png',
                width: 40,
              )
            ]));
  }
}
