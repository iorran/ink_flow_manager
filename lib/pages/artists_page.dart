import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:ink_flow_manager/components/menu.dart';
import 'package:ink_flow_manager/models/artist.dart';
import 'package:ink_flow_manager/providers/artist_provider.dart';
import 'package:ink_flow_manager/services/artist_Service.dart';
import 'package:ink_flow_manager/utils/form_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistService artistService = ArtistService();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController textFieldController = TextEditingController();

    addArtist() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Artista'),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: textFieldController,
                decoration: const InputDecoration(hintText: "Nome"),
                validator: FormValidators.isRequired,
                autofocus: true,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCELAR'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('SALVAR'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Artist artist = Artist(
                      name: textFieldController.text,
                      createdAt: Timestamp.now(),
                    );
                    artistService.save(artist);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "A R T I S T A S",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Adicionar um artista',
            onPressed: addArtist,
          ),
        ],
      ),
      drawer: const Menu(),
      body: Center(
        child: Consumer<ArtistProvider>(
          builder: (context, value, child) {
            final artistProvider = context.read<ArtistProvider>();
            return PaginateFirestore(
              query: artistService.collection
                  .orderBy("deletedAt", descending: false)
                  .orderBy("active", descending: false)
                  .orderBy("createdAt", descending: true),
              itemBuilderType: PaginateBuilderType.listView,
              itemsPerPage: 5,
              isLive: true,
              initialLoader:
                  const Center(child: CircularProgressIndicator.adaptive()),
              onEmpty: const Text('Registre um novo artista :)'),
              itemBuilder: (context, snapshot, index) {
                final Map<String, dynamic> json =
                    snapshot[index].data() as Map<String, dynamic>;
                json['id'] = snapshot[index].id;
                Artist artist = Artist.fromJson(json);
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () => {
                          artistProvider.edit(Artist.fromJson(json)),
                          Navigator.pushNamed(context, '/edit-artist'),
                        },
                        child: PhysicalModel(
                          color: artist.deletedAt != null
                              ? Colors.red.shade100
                              : Colors.white,
                          elevation: 8,
                          borderRadius: BorderRadius.circular(4),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                artist.deletedAt != null
                                    ? SlidableAction(
                                        label: 'Restaurar',
                                        icon: Icons.undo,
                                        backgroundColor: Colors.green,
                                        onPressed: (context) => {
                                          artistProvider
                                              .restore(Artist.fromJson(json)),
                                          artistService.save(value.artist),
                                        },
                                      )
                                    : SlidableAction(
                                        label: 'Remover',
                                        icon: Icons.remove,
                                        backgroundColor: Colors.red,
                                        onPressed: (context) => {
                                          artistProvider
                                              .delete(Artist.fromJson(json)),
                                          artistService.save(value.artist),
                                        },
                                      ),
                              ],
                            ),
                            child: listTile(artist),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  ListTile listTile(Artist artist) {
    return ListTile(
      leading: tileIndicator(artist),
      title: Text(artist.name),
      subtitle: Text(
          DateFormat('dd/MM/yyyy, HH:mm').format(artist.createdAt.toDate())),
      trailing: const Icon(Icons.edit),
    );
  }

  Icon tileIndicator(Artist artist) {
    if (artist.deletedAt != null) {
      return const Icon(
        Icons.delete_forever,
        color: Colors.red,
        size: 20,
      );
    }
    return !artist.active
        ? Icon(
            Icons.warning,
            color: Colors.amber.shade900,
            size: 20,
          )
        : const Icon(
            Icons.check,
            color: Colors.green,
            size: 20,
          );
  }
}
