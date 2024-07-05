import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class KeterlambatanController extends GetxController {
  TextEditingController deskC = TextEditingController();
  String id = '';
  String nama = '';
  String nisn = '';
  String kelas = '';
  String kedatangan = '';
  String hukum = '';
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> cekLaporan(String id) async {
    try {
      var hasil = await firestore.collection("keterlambatan").doc(id).get();
      if (hasil.data() != null) {
        return {
          "hasil": "ada",
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

  Future<void> kirimLaporan() async {
    isLoading.value = true;
    Map<String, dynamic> hasilCek = await cekLaporan(id);
    if (hasilCek['hasil'] == "ada") {
      Get.snackbar("Gagal", "Siswa $nama telah dilaporkan sebelumnya");
      isLoading.value = false;
    } else {
      try {
        if (deskC.text.isNotEmpty) {
          await firestore.collection("keterlambatan").doc(id).set({
            "id": id,
            "nama": nama,
            "nisn": nisn,
            "kelas": kelas,
            "kedatangan": kedatangan,
            "status hukuman": hukum,
            "deskripsi": deskC.text,
            "createdAt": DateTime.now().toIso8601String(),
          });
        } else {
          await firestore.collection("keterlambatan").doc(id).set({
            "id": id,
            "nama": nama,
            "nisn": nisn,
            "kelas": kelas,
            "kedatangan": kedatangan,
            "status hukuman": hukum,
            "deskripsi": "kosong",
            "createdAt": DateTime.now().toIso8601String(),
          });
        }

        Get.snackbar("Sukses", "Siswa berhasil dilaporkan");
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengirim laporan");
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
