import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class ListIzinKeluarController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var dateTime = DateTime.now();
  var dateFormat = DateFormat('yyyy-MM-dd');

  Stream<QuerySnapshot<Object?>> streamLaporan() async* {
    var formattedDate = dateFormat.format(dateTime);
    CollectionReference siswa = firestore.collection("izin keluar");
    yield* siswa
        .where('createdAt', isGreaterThanOrEqualTo: formattedDate)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> hapusData(String id) async {
    try {
      await firestore.collection("izin keluar").doc(id).delete();
      Get.back();
      Get.snackbar("Berhasil", "Data berhasil dihapus");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal menghapus data");
      Get.back();
    }
  }

  Future<void> updateIzin(String id) async {
    try {
      await firestore.collection("izin keluar").doc(id).update({
        "status siswa": "sudah kembali",
        "kembali pada": "${DateFormat.jms().format(DateTime.now())}",
        "updatedAt": DateTime.now().toIso8601String(),
      });

      Get.snackbar("Sukses", "Perzinan Berhasil Diperbaharui");
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal mengupdate data");
      Get.back();
    }
  }
}
