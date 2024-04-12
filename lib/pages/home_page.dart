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
                    child: Image.memory(
                      getImageBinary(data['signature']),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Item(
                    label: "Data: ",
                    value: DateFormat('dd/MM/yyyy, HH:mm').format(
                      data['created'].toDate(),
                    ),
                  ),
                  Item(
                    label: "Nome: ",
                    value: data['name'],
                  ),
                  Item(
                    label: "Email: ",
                    value: data['email'],
                  ),
                  Item(
                    label: "Aniversário: ",
                    value: data['birthday'],
                  ),
                  Item(
                    label: "Documento: ",
                    value: data['document'],
                  ),
                  Item(
                    label: "Tel: ",
                    value: data['phone'],
                  ),
                  Item(
                    label:
                        "Indique se há diagnóstico positivo para Hepatite B e C, HIV/AIDS, sífilis, tuberculose, herpes, eczema, psoríase, acne, rosácea, diabetes, distúrbios de coagulação sanguínea, problemas cardíacos, doenças autoimunes, câncer, epilepsia, gravidez, queloide, anemia, hemofilia ou doença autoimune, vitiligo.: ",
                    value: data['s2Q1'],
                  ),
                  Item(
                    label: "Faz de uso de medicação de uso contínuo?: ",
                    value: data['s2Q2'],
                  ),
                  Item(
                    label: "Possui Alergia a algum cosmético?: ",
                    value: data['s2Q3'],
                  ),
                  Item(
                    label: "Tem cirurgia recente no local?: ",
                    value: data['s2Q4'],
                  ),
                  Item(
                    label:
                        "Afirmo ter conferido todos os detalhes da tatuagem (posição, grafia, datas, desenho, etc). Estou ciente de que a tatuagem é um processo artístico: ",
                    value: data['s3Q1'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Não fiz uso de nenhum anestésico e estou ciente que caso seja descoberto o uso durante o procedimento, o mesmo será interrompido sem devolução do valor pago: ",
                    value: data['s3Q2'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label: "Confirmo ter mais de 18 Anos: ",
                    value: data['s3Q3'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Afirmo ter ciência de há câmeras no ambiente laboral e autorizo a gravação de minha imagem: ",
                    value: data['s3Q4'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label: "Indique o valor da tatuagem: ",
                    value: data['s3Q5'],
                  ),
                  Item(
                    label: "Zona do corpo a ser feito: ",
                    value: data['s3Q6'],
                  ),
                  Item(
                    label: "Desenho: ",
                    value: data['s3Q7'],
                  ),
                  Item(
                    label:
                        "Comprometo-me a seguir as instruções repassadas pelo profissional, a fim de que a cicatrização seja a melhor possível, estando ciente de que cada pessoa possui um tempo específico e próprio de reação: ",
                    value: data['s4Q1'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Estou ciente de que qualquer problema com a minha tatuagem deve ser tratado diretamente com o tatuador: ",
                    value: data['s4Q2'] ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Autorizo a veiculação do trabalho executado através meio de comunicação isentando-o de qualquer bônus e/ou ônus advindo da exposição da imagem e qualquer processo decorrente: ",
                    value: data['s4Q3'] ? "Sim" : "Nāo",
                  ),
                  const SizedBox(height: 90)
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
