import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ink_flow_manager/models/artist.dart';

class ArtistService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("artists");
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> save(Artist artist) {
    if (artist.id != null) {
      return collection.doc(artist.id).update(artist.toJson());
    }
    return collection.add(artist.toJson());
  }

  Future<String> uploadAvatar(Artist artist, Uint8List avatar) async {
    Reference ref = storage.ref().child(
        'Artist Avatar: ${artist.id} - ${artist.createdAt.millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putData(avatar);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<String> uploadSignature(Artist artist, Uint8List signature) async {
    Reference ref = storage.ref().child(
        'Artist Signature: ${artist.id} - ${artist.createdAt.millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putData(signature);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<List<Artist>> listAvailable() async {
    List<Artist> docList = [];
    await collection.where('active', isEqualTo: true).get().then((value) {
      for (final child in value.docs) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(child.data() as Map);
        data['id'] = child.id;
        docList.add(Artist.fromJson(data));
      }
    });
    return docList;
  }
}
