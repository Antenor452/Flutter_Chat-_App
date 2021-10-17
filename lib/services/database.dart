import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByusername(String username) async {}

  uploadUserInfo(userMap) async {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
}
