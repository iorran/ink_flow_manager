import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ink_flow_manager/models/term.dart';

class TermService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("terms");

  Future<void> save(Term term) {
    return collection.add({
      'name': term.birthday,
      'birthday': term.birthday,
      'document': term.document,
      'phone': term.phone,
      'whereFoundUs': term.whereFoundUs,
      's2Q1': term.s2Q1,
      's2Q2': term.s2Q2,
      's2Q3': term.s2Q3,
      's2Q4': term.s2Q4,
      's3Q1': term.s3Q1,
      's3Q2': term.s3Q2,
      's3Q3': term.s3Q3,
      's4Q1': term.s4Q1,
      's4Q2': term.s4Q2,
      's4Q3': term.s4Q3,
      's4Q4': term.s4Q4,
      'signature': term.signature,
      'created': term.created,
    });
  }
}
