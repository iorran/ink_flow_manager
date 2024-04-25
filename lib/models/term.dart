import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class Term {
  String? id;
  String? artistId;
  String? name;
  String? email;
  Timestamp? birthday;
  String? document;
  String? phone;
  String? whereFoundUs;
  String? s2Q1;
  String? s2Q2;
  String? s2Q3;
  String? s2Q4;
  bool? s3Q1;
  bool? s3Q2;
  bool? s3Q3;
  bool? s3Q4;
  bool? s4Q1;
  bool? s4Q2;
  bool? s4Q3;
  String? signature;
  final Timestamp createdAt = Timestamp.now();

  Term({
    required this.artistId,
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
    required this.s4Q1,
    required this.s4Q2,
    required this.s4Q3,
  });

  static Uint8List? getImageBinary(dynamicList) {
    if (dynamicList == null) {
      return null;
    }
    List<int> intList = dynamicList.cast<int>().toList();
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }

  Term.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? json['id'] as String : null,
        artistId = json['artistId'],
        name = json['name'],
        email = json['email'],
        birthday = json['birthday'],
        document = json['document'],
        phone = json['phone'],
        whereFoundUs = json['whereFoundUs'],
        s2Q1 = json['s2Q1'],
        s2Q2 = json['s2Q2'],
        s2Q3 = json['s2Q3'],
        s2Q4 = json['s2Q4'],
        s3Q1 = json['s3Q1'],
        s3Q2 = json['s3Q2'],
        s3Q3 = json['s3Q3'],
        s3Q4 = json['s3Q4'],
        s4Q1 = json['s4Q1'],
        s4Q2 = json['s4Q2'],
        s4Q3 = json['s4Q3'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'birthday': birthday,
        'document': document,
        'phone': phone,
        'whereFoundUs': whereFoundUs,
        's2Q1': s2Q1,
        's2Q2': s2Q2,
        's2Q3': s2Q3,
        's2Q4': s2Q4,
        's3Q1': s3Q1,
        's3Q2': s3Q2,
        's3Q3': s3Q3,
        's3Q4': s3Q4,
        's4Q1': s4Q1,
        's4Q2': s4Q2,
        's4Q3': s4Q3,
        'signature': signature,
        'createdAt': createdAt,
      };
}
