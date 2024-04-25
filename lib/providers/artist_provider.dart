import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ink_flow_manager/models/artist.dart';

class ArtistProvider extends ChangeNotifier {
  late Artist artist;

  void edit(Artist artist) {
    this.artist = artist;
    notifyListeners();
  }

  void setSignature(String? signature) {
    artist.active = true;
    artist.signature = signature;
    notifyListeners();
  }

  void setImage(String avatar) {
    artist.photo = avatar;
    notifyListeners();
  }

  void delete(Artist artist) {
    this.artist = artist;
    artist.deletedAt = Timestamp.now();
    notifyListeners();
  }

  void restore(Artist artist) {
    this.artist = artist;
    artist.deletedAt = null;
    notifyListeners();
  }
}
