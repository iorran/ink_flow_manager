import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:ink_flow_manager/services/term_service.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TermService termService = TermService();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Uint8List getImageBinary(dynamicList) {
    List<int> intList = dynamicList.cast<int>().toList();
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }

  showDetails(BuildContext context, Map<dynamic, dynamic> data) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Detalhes",
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: const Text(
                "Detalhes",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              elevation: 0.0),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Image.memory(getImageBinary(data['signature']))),
                  const SizedBox(height: 20),
                  Item(
                      label: "Data: ",
                      value: DateFormat('dd/MM/yyyy, HH:mm')
                          .format(data['created'].toDate())),
                  Item(label: "Nome: ", value: data['name']),
                  Item(label: "Email: ", value: data['email']),
                  Item(label: "Aniversário: ", value: data['birthday']),
                  Item(label: "Documento: ", value: data['document']),
                  Item(label: "Tel: ", value: data['phone']),
                  Item(
                      label:
                          "Indique se há diagnóstico positivo para Hepatite B e C, HIV/AIDS, sífilis, tuberculose, herpes, eczema, psoríase, acne, rosácea, diabetes, distúrbios de coagulação sanguínea, problemas cardíacos, doenças autoimunes, câncer, epilepsia, gravidez, queloide, anemia, hemofilia ou doença autoimune, vitiligo.: ",
                      value: data['s2Q1']),
                  Item(
                      label: "Faz de uso de medicação de uso contínuo?: ",
                      value: data['s2Q2']),
                  Item(
                      label: "Possui Alergia a algum cosmético?: ",
                      value: data['s2Q3']),
                  Item(
                      label: "Tem cirurgia recente no local?: ",
                      value: data['s2Q4']),
                  Item(
                      label: "Indique o valor da tatuagem: ",
                      value: data['s3Q1']),
                  Item(
                      label: "Zona do corpo a ser feito: ",
                      value: data['s3Q2']),
                  Item(label: "Desenho: ", value: data['s3Q3']),
                  Item(label: "P2: ", value: data['s4Q1']),
                  Item(label: "P2: ", value: data['s4Q2']),
                  Item(label: "P2: ", value: data['s4Q3']),
                  Item(label: "P2: ", value: data['s4Q4']),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          "A K A T S U K I",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: PaginateFirestore(
          query: termService.collection.orderBy("created", descending: true),
          itemBuilderType: PaginateBuilderType.listView,
          itemsPerPage: 5,
          isLive: true,
          initialLoader:
              const Center(child: CircularProgressIndicator.adaptive()),
          onEmpty: const Center(
            child: Text('Registre um novo termo de resposabilidade!'),
          ),
          onError: (e) => const Center(
            child: Text('Nāo consegui carregar os dados :('),
          ),
          itemBuilder: (context, snapshot, index) {
            final Map<dynamic, dynamic> json =
                snapshot[index].data() as Map<dynamic, dynamic>;
            final String name = json['name'];
            final Timestamp created = json['created'];
            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => showDetails(context, json),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(4),
                      child: ListTile(
                        title: Text(name),
                        subtitle: Text(DateFormat('dd/MM/yyyy, HH:mm')
                            .format(created.toDate())),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/consent');
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String label;
  final String? value;

  const Item({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return value != null && value != ''
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                Text(
                  label,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(value!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16))
              ],
            ),
          )
        : const SizedBox(height: 0);
  }
}
