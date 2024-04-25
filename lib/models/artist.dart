import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  String? id;
  String name;
  String? photo;
  String? signature;
  bool active;
  Timestamp? deletedAt;
  Timestamp createdAt;

  Artist({
    required this.name,
    required this.createdAt,
    this.active = false,
  });

  static Uint8List? getImageBinary(dynamicList) {
    if (dynamicList == null) {
      return null;
    }
    List<int> intList = dynamicList.cast<int>().toList();
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }

  Artist.fromJson(Map<String, dynamic> json)
      : id = json['id'] != null ? json['id'] as String : null,
        name = json['name'] as String,
        active = json['active'] as bool,
        deletedAt =
            json['deletedAt'] != null ? json['deletedAt'] as Timestamp : null,
        createdAt = json['createdAt'] as Timestamp,
        photo = json['photo'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'signature': signature,
        'photo': photo,
        'active': active,
        'createdAt': createdAt,
        'deletedAt': deletedAt,
      };
}
