import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class Term {
  String name;
  String email;
  String birthday;
  String document;
  String phone;
  String whereFoundUs;
  String s2Q1;
  String s2Q2;
  String s2Q3;
  String s2Q4;
  bool s3Q1;
  bool s3Q2;
  bool s3Q3;
  bool s3Q4;
  String s3Q5;
  String s3Q6;
  String s3Q7;
  bool s4Q1;
  bool s4Q2;
  bool s4Q3;
  Uint8List? signature;
  final Timestamp created = Timestamp.now();

  Term({
    required this.name,
    required this.email,
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
    required this.s3Q4,
    required this.s3Q5,
    required this.s3Q6,
    required this.s3Q7,
    required this.s4Q1,
    required this.s4Q2,
    required this.s4Q3,
    required this.signature,
  });
}
