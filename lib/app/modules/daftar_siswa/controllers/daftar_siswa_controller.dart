import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DaftarSiswaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamSiswa() async* {
    CollectionReference siswa = firestore.collection("siswa");
    yield* siswa.orderBy('nama siswa').snapshots();
  }
}
