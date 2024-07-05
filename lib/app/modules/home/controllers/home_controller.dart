import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("user").doc(uid).snapshots();
  }

  Future<Map<String, dynamic>> cekRole() async {
    String uid = auth.currentUser!.uid;
    try {
      var hasil = await firestore.collection("user").doc(uid).get();
      if (hasil.data() != null) {
        return {
          "hasil": "ada",
          "data": hasil.data(),
        };
      } else {
        return {
          "hasil": null,
        };
      }
    } catch (e) {
      return {
        "hasil": null,
      };
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamAbsenToday() async* {
    String uid = auth.currentUser!.uid;
    Map<String, dynamic> hasilCek = await cekRole();
    String idAbsen = hasilCek['data']['id presen'];

    yield* firestore
        .collection("user")
        .doc(uid)
        .collection("presensi")
        .doc(idAbsen)
        .snapshots();
  }
}
