import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";

  String? id;
  String? name;
  String? email;

  UserModel({required this.id, required this.name, required this.email});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data() as dynamic)[NAME] ?? 'name';
    email = (snapshot.data() as dynamic)[EMAIL] ?? 'name';
    id = (snapshot.data() as dynamic)[ID] ?? 'name';
  }
}