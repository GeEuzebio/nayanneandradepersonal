// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:nayanneandradepersonal/controlers/firebase_controlers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AvaliacaoPDF extends StatefulWidget {
  final Map<String, double> perimetrias;
  final Map<String, double> dobras;
  final String nome;
  final String gender;
  final String birthDay;
  final String email;

  const AvaliacaoPDF(
      {super.key,
      required this.nome,
      required this.gender,
      required this.birthDay,
      required this.email,
      required this.perimetrias,
      required this.dobras});

  @override
  State<AvaliacaoPDF> createState() => _AvaliacaoPDFState();
}

class _AvaliacaoPDFState extends State<AvaliacaoPDF> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> perimetria = [];
  List<QueryDocumentSnapshot> dobra = [];
  List<Map<String, dynamic>> listPerimetrias = [];
  List<Map<String, dynamic>> listDobras = [];

  Future<void> getPerimetrias() async {
    uploadPerimetrias(widget.perimetrias, widget.email);
    QuerySnapshot query = await firestore
        .collectionGroup('perimetrias')
        .where('email', isEqualTo: widget.email)
        .get();
    perimetria = query.docs;
    listPerimetrias =
        perimetria.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  Future<void> getDobras() async {
    uploadDobras(
        widget.dobras, widget.email, widget.birthDay, widget.gender);
    QuerySnapshot query = await firestore
        .collectionGroup('dobras')
        .where('email', isEqualTo: widget.email)
        .get();
    dobra = query.docs;
    listDobras = dobra.map((e) => e.data() as Map<String, dynamic>).toList();
  }

  Future<void> createEvaluation() async {
    await getPerimetrias();
    await getDobras();
    //listas com dados das perimetrias
    List<dynamic> datas =
        listPerimetrias.map((e) => e['dataAvaliacao']).toList();
    List<dynamic> pescoco = listPerimetrias.map((e) => e['pescoco']).toList();
    List<dynamic> peitoral = listPerimetrias.map((e) => e['peitoral']).toList();
    List<dynamic> bicE = listPerimetrias.map((e) => e['bicE']).toList();
    List<dynamic> bicD = listPerimetrias.map((e) => e['bicD']).toList();
    List<dynamic> antE = listPerimetrias.map((e) => e['antE']).toList();
    List<dynamic> antD = listPerimetrias.map((e) => e['antD']).toList();
    List<dynamic> cintura = listPerimetrias.map((e) => e['cintura']).toList();
    List<dynamic> quadril = listPerimetrias.map((e) => e['quadril']).toList();
    List<dynamic> coxaE = listPerimetrias.map((e) => e['coxaE']).toList();
    List<dynamic> coxaD = listPerimetrias.map((e) => e['coxaD']).toList();
    List<dynamic> pantE = listPerimetrias.map((e) => e['pantE']).toList();
    List<dynamic> pantD = listPerimetrias.map((e) => e['pantD']).toList();
    //listas com dados das dobras
    List<dynamic> dobraPeitoral =
        listDobras.map((e) => e['dobraPeitoral']).toList();
    List<dynamic> axial = listDobras.map((e) => e['axial']).toList();
    List<dynamic> subscapular =
        listDobras.map((e) => e['subscapular']).toList();
    List<dynamic> triciptal = listDobras.map((e) => e['triciptal']).toList();
    List<dynamic> suprailiaca =
        listDobras.map((e) => e['suprailiaca']).toList();
    List<dynamic> abdominal = listDobras.map((e) => e['abdominal']).toList();
    List<dynamic> coxal = listDobras.map((e) => e['coxal']).toList();
    List<dynamic> gordura =
        listDobras.map((e) => e['percentualGordura']).toList();
    final pdf = pw.Document();
    pw.Font font =
        pw.Font.ttf(await rootBundle.load('fonts/arial-font/arial.ttf'));
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.Text('Nome: ${widget.nome}', style: pw.TextStyle(font: font)),
            pw.Text('Sexo: ${widget.gender}', style: pw.TextStyle(font: font)),
            pw.Text('Data de Nascimento: ${widget.birthDay}',
                style: pw.TextStyle(font: font)),
            pw.Text('Email: ${widget.email}', style: pw.TextStyle(font: font)),
            pw.SizedBox(height: 50),
            pw.Table(border: pw.TableBorder.all(), children: [
              pw.TableRow(
                  decoration: const pw.BoxDecoration(
                      color: PdfColor.fromInt(0xFFE91E63)),
                  children: [
                    pw.Text('Perimetrias',
                        style:
                            pw.TextStyle(font: font, color: PdfColors.white)),
                    ...datas
                        .map((e) => pw.Text(e,
                            style: pw.TextStyle(
                                font: font, color: PdfColors.white)))
                        .toList(),
                  ]),
              pw.TableRow(children: [
                pw.Text('Pescoço',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...pescoco
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList(),
              ]),
              pw.TableRow(children: [
                pw.Text('Peitoral',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...peitoral
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Bíceps\nEsquerdo',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...bicE
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Bíceps\nDireito',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...bicD
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Antebraço\nEsquerdo',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...antE
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Antebraço\nDireito',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...antD
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Cintura',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...cintura
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Quadril',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...quadril
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Coxa\nEsquerda',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...coxaE
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Coxa\nDireita',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...coxaD
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Panturrilha\nEsquerda',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...pantE
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Panturrilha\nDireita',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...pantD
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(
                  decoration: const pw.BoxDecoration(
                      color: PdfColor.fromInt(0xFFE91E63)),
                  children: [
                    pw.Text('Dobras\nCutâneas',
                        style:
                            pw.TextStyle(font: font, color: PdfColors.white)),
                    ...datas
                        .map((e) => pw.Text(e,
                            style: pw.TextStyle(
                                font: font, color: PdfColors.white)))
                        .toList()
                  ]),
              pw.TableRow(children: [
                pw.Text('Peitoral',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...dobraPeitoral
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Axial',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...axial
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Subscapular',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...subscapular
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Triciptal',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...triciptal
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Suprailíaca',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...suprailiaca
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Abdominal',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...abdominal
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('Coxal',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...coxal
                    .map((e) =>
                        pw.Text(e.toString(), style: pw.TextStyle(font: font)))
                    .toList()
              ]),
              pw.TableRow(children: [
                pw.Text('% de Gordura',
                    style: pw.TextStyle(
                        font: font, fontWeight: pw.FontWeight.bold)),
                ...gordura
                    .map((e) => pw.Text(e.toStringAsFixed(2),
                        style: pw.TextStyle(font: font)))
                    .toList()
              ]),
            ]),
          ]));
        }));
    final String dir = (await getExternalStorageDirectory())!.path;
    final String name =
        'Avaliacao${widget.nome}'.splitMapJoin(' ', onNonMatch: (n) {
      return n;
    }, onMatch: (m) {
      return '';
    });
    final String path = '$dir/$name.pdf';
    final file = File(path);
    file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: createEvaluation, child: const Text('Realizar Avaliação'));
  }
}
