import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class IzinKeluarController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> ScanIzinSementara() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Batal", true, ScanMode.QR);
    if (barcodeScanRes != null) {
      Map<String, dynamic> hasil = await getSiswabyNisn(barcodeScanRes);

      if (hasil['error'] == false) {
        Get.toNamed(Routes.IZIN_SEMENTARA, arguments: hasil['data']);
      } else {
        Get.snackbar("Terjadi Keasalahan", hasil['message']);
      }
    }
    print(barcodeScanRes);
  }

  Future<void> ScanIzinPulang() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Batal", true, ScanMode.QR);
    if (barcodeScanRes != null) {
      Map<String, dynamic> hasil = await getSiswabyNisn(barcodeScanRes);

      if (hasil['error'] == false) {
        Get.toNamed(Routes.IZIN_PULANG, arguments: hasil['data']);
      } else {
        Get.snackbar("Terjadi Keasalahan", hasil['message']);
      }
    }
    print(barcodeScanRes);
  }

  Future<Map<String, dynamic>> getSiswabyNisn(String nisn) async {
    try {
      // var hasil = await firestore.collection("siswa").doc(nisn).get();
      var hasil = await firestore
          .collection("siswa")
          .where("nisn", isEqualTo: nisn)
          .get();

      if (hasil.docs.first.data() != null) {
        return {
          "error": false,
          "message": "Berhasil mendapatkan data",
          "data": hasil.docs.first.data()!,
        };
      } else {
        return {
          "error": true,
          "message": "Tidak ada data ini di dalam database, cek kembali",
        };
      }
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": "Tidak dapat mengambil data dengan kode ini",
      };
    }
  }
}
