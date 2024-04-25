import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:ink_flow_manager/components/menu.dart';
import 'package:ink_flow_manager/models/term.dart';
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

  showDetails(BuildContext context, Term term) {
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
              },
            ),
            title: const Text(
              "Detalhes",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: term.signature != null
                        ? Image.network(term.signature!)
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Item(
                    label: "Data: ",
                    value: DateFormat('dd/MM/yyyy, HH:mm').format(
                      term.createdAt.toDate(),
                    ),
                  ),
                  Item(
                    label: "Nome: ",
                    value: term.name,
                  ),
                  Item(
                    label: "Email: ",
                    value: term.email,
                  ),
                  Item(
                      label: "Aniversário: ",
                      value: term.birthday != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(term.birthday!.toDate())
                          : null),
                  Item(
                    label: "Documento: ",
                    value: term.document,
                  ),
                  Item(
                    label: "Tel: ",
                    value: term.phone,
                  ),
                  Item(
                    label: "Onde nos encontrou: ",
                    value: term.whereFoundUs,
                  ),
                  Item(
                    label:
                        "Indique se há diagnóstico positivo para Hepatite B e C, HIV/AIDS, sífilis, tuberculose, herpes, eczema, psoríase, acne, rosácea, diabetes, distúrbios de coagulação sanguínea, problemas cardíacos, doenças autoimunes, câncer, epilepsia, gravidez, queloide, anemia, hemofilia ou doença autoimune, vitiligo.: ",
                    value: term.s2Q1,
                  ),
                  Item(
                    label: "Faz de uso de medicação de uso contínuo?: ",
                    value: term.s2Q2,
                  ),
                  Item(
                    label: "Possui Alergia a algum cosmético?: ",
                    value: term.s2Q3,
                  ),
                  Item(
                    label: "Tem cirurgia recente no local?: ",
                    value: term.s2Q4,
                  ),
                  Item(
                    label:
                        "Afirmo ter conferido todos os detalhes da tatuagem (posição, grafia, datas, desenho, etc). Estou ciente de que a tatuagem é um processo artístico: ",
                    value: term.s3Q1 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Não fiz uso de nenhum anestésico e estou ciente que caso seja descoberto o uso durante o procedimento, o mesmo será interrompido sem devolução do valor pago: ",
                    value: term.s3Q2 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label: "Confirmo ter mais de 18 Anos: ",
                    value: term.s3Q3 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Afirmo ter ciência de há câmeras no ambiente laboral e autorizo a gravação de minha imagem: ",
                    value: term.s3Q4 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Comprometo-me a seguir as instruções repassadas pelo profissional, a fim de que a cicatrização seja a melhor possível, estando ciente de que cada pessoa possui um tempo específico e próprio de reação: ",
                    value: term.s4Q1 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Estou ciente de que qualquer problema com a minha tatuagem deve ser tratado diretamente com o tatuador: ",
                    value: term.s4Q2 != null ? "Sim" : "Nāo",
                  ),
                  Item(
                    label:
                        "Autorizo a veiculação do trabalho executado através meio de comunicação isentando-o de qualquer bônus e/ou ônus advindo da exposição da imagem e qualquer processo decorrente: ",
                    value: term.s4Q3 != null ? "Sim" : "Nāo",
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
      ),
      drawer: const Menu(),
      body: Center(
        child: PaginateFirestore(
          query: termService.collection.orderBy("createdAt", descending: true),
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
            final Map<String, dynamic> json =
                snapshot[index].data() as Map<String, dynamic>;
            json['id'] = snapshot[index].id;
            Term term = Term.fromJson(json);
            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => showDetails(context, term),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(4),
                      child: ListTile(
                        title: Text(term.name!),
                        subtitle: Text(DateFormat('dd/MM/yyyy, HH:mm')
                            .format(term.createdAt.toDate())),
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
