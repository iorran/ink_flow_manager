import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class Term {
  String name;
  String birthday;
  String document;
  String phone;
  String whereFoundUs;
  String s2Q1;
  String s2Q2;
  String s2Q3;
  String s2Q4;
  String s3Q1;
  String s3Q2;
  String s3Q3;
  String s4Q1;
  String s4Q2;
  String s4Q3;
  String s4Q4;
  Uint8List? signature;
  final Timestamp created = Timestamp.now();

  Term({
    required this.name,
    required this.birthday,
    required this.document,
    required this.phone,
    required this.whereFoundUs,
    required this.s2Q1,
    required this.s2Q2,
    required this.s2Q3,
    required this.s2Q4,
    required this.s3Q1,
    required this.s3Q2,
    required this.s3Q3,
    required this.s4Q1,
    required this.s4Q2,
    required this.s4Q3,
    required this.s4Q4,
    required this.signature,
  });
}
