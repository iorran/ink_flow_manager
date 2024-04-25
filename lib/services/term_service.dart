import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ink_flow_manager/models/term.dart';

class TermService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("terms");
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> save(Term term, Uint8List? signature) async {
    DocumentReference<Object?> savedTerm = await collection.add(term.toJson());
    term.id = savedTerm.id;
    term.signature = await uploadSignature(term, signature!);
    collection.doc(savedTerm.id).update(term.toJson());
  }

  Future<String> uploadSignature(Term term, Uint8List signature) async {
    Reference ref = storage.ref().child(
        'Term Signature: ${term.id} ${term.createdAt.millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putData(signature);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
