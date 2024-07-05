import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ListKeterlambatanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> streamLaporan() async* {
    CollectionReference siswa = firestore.collection("keterlambatan");
    yield* siswa.orderBy('createdAt', descending: true).snapshots();
  }

  void hapusData(String id) async {
    try {
      await firestore.collection("keterlambatan").doc(id).delete();
      Get.back();
      Get.snackbar("Berhasil", "Data berhasil dihapus");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal menghapus data");
      Get.back();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("user").doc(uid).snapshots();
  }
}
