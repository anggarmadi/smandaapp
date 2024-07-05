import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListUserController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamUser() async* {
    yield* firestore
        .collection("user")
        .where("role", isNotEqualTo: "admin")
        .snapshots();
  }
}
