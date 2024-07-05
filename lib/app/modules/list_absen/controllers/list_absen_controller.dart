import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';

class ListAbsenController extends GetxController {
  final pageC = Get.find<PageAdminIndexController>();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAbsen() async* {
    String uid = auth.currentUser!.uid;
    if (pageC.role == "admin") {
      uid = Get.arguments;
      print(uid);
    }
    yield* firestore
        .collection("user")
        .doc(uid)
        .collection("presensi")
        .orderBy("date", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("user").doc(uid).snapshots();
  }
}
