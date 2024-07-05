import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/routes/app_pages.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geocoding/geocoding.dart';

class PageAdminIndexController extends GetxController {
  int radiusMinimal = 150;
  RxBool isLoading = false.obs;
  RxInt pageIndex = 0.obs;
  var hukum = '';
  String role = "";
  String dayPresensi =
      "${DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-")}";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() async {
    super.onInit();
    var uid = await FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      Map<String, dynamic> hasilCek = await cekRole();
      if (hasilCek['hasil'] == "ada") {
        role = hasilCek['data']['role'];
        print("Jalan kok $role");
      }

      var hasilPresensi = await firestore
          .collection("user")
          .doc(uid)
          .collection("presensi")
          .where("day", isEqualTo: dayPresensi)
          .get();

      if (hasilPresensi.docs.isEmpty) {
        //berarti dah beda hari
        if (hasilCek['data']['status absen'] != null) {
          //berarti udah ganti hari tapi belum ada absen keluar
          await firestore.collection("user").doc(uid).update({
            "status absen": FieldValue.delete(),
            "id presen": FieldValue.delete(),
            "tabelUid": FieldValue.delete(),
          });
        }
      }
    }
  }

  Future<Map<String, dynamic>> cekRole() async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    try {
      var hasil = await firestore.collection("user").doc(uid).get();
      if (hasil.data() != null) {
        Map<String, dynamic> hasilCek = hasil.data()!;
        role = hasilCek['role'];
        print(role);
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

  Future<void> updatePosition(Position posisi, String address) async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    await firestore.collection("user").doc(uid).update({
      "posisi": {
        "lat": posisi.latitude,
        "long": posisi.longitude,
      },
      "alamat": address,
    });
  }

  Future<Map<String, dynamic>> getSiswabyNisn(String nisn) async {
    try {
      // var hasil = await firestore.collection("siswa").doc(nisn).get();
      var hasil = await firestore
          .collection("siswa")
          .where("nisn", isEqualTo: nisn)
          .get();

      if (hasil.docs.first.data() != null) {
        cekHukuman();
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

  void changePage(int i) async {
    print('click index=$i');
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.DAFTAR_SISWA);
        break;
      case 2:
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Batal", true, ScanMode.QR);
        if (barcodeScanRes != null) {
          Map<String, dynamic> hasil = await getSiswabyNisn(barcodeScanRes);
          hasil['data']['hukum'] = hukum;

          if (hasil['error'] == false) {
            Get.toNamed(Routes.KETERLAMBATAN, arguments: hasil['data']);
          } else {
            Get.snackbar("Terjadi Keasalahan", hasil['message']);
          }
        }
        print(barcodeScanRes);
        break;
      case 3:
        Get.offAllNamed(Routes.REKAP);
        break;
      case 4:
        Get.offAllNamed(Routes.PROFIL);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  void changePageUser(int i) async {
    print('click index=$i');
    pageIndex.value = i;
    switch (i) {
      case 1:
        Get.offAllNamed(Routes.LIST_KETERLAMBATAN);
        break;
      case 2:
        String uid = await FirebaseAuth.instance.currentUser!.uid;
        // ambil data user
        var hasil = await firestore.collection("user").doc(uid).get();
        Map<String, dynamic> hasilCek = hasil.data()!;
        print(hasilCek['status absen']);
        // cek dah absen atau belum
        if (hasilCek['status absen'] != null) {
          // coding untuk keluar
          Get.defaultDialog(
            title: "SAPP SMAN 2 TEBO",
            // middleText: "Apakah anda akan melakukan presensi di ${hasilScanQr['data']['ruang']} ?"
            middleText: "Apakah anda yakin untuk presensi keluar",
            actions: [
              OutlinedButton(
                onPressed: () => Get.back(),
                child: Text("Batal"),
              ),
              Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (isLoading.value == false) {
                        isLoading.value = true;
                        Map<String, dynamic> dataResponse =
                            await determinePosition();
                        if (dataResponse["error"] != true) {
                          Position position = dataResponse["posisi"];

                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  position.latitude, position.longitude);
                          String address =
                              "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
                          await updatePosition(position, address);

                          double distance = Geolocator.distanceBetween(
                              -1.3133071,
                              102.1073423,
                              position.latitude,
                              position.longitude);

                          await presensiKeluar(position, address,
                              hasilCek['status absen'], distance);
                          Get.back();
                          Get.snackbar("Berhasil", "Melakukan presensi keluar");
                          isLoading.value = false;
                        } else {
                          isLoading.value = false;
                          Get.snackbar(
                              "Terjadi Kesalahan", dataResponse['message']);
                        }
                      }
                    },
                    child:
                        Text(isLoading.value == false ? "Yakin" : "Loading..."),
                  )),
            ],
          );
        } else {
          // coding untuk masuk
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#000000", "Batal", true, ScanMode.QR);
          if (barcodeScanRes != null) {
            Map<String, dynamic> hasilScanQr = await getRuangan(barcodeScanRes);

            if (hasilScanQr['error'] == false) {
              Get.defaultDialog(
                title: "SAPP SMAN 2 TEBO",
                // middleText: "Apakah anda akan melakukan presensi di ${hasilScanQr['data']['ruang']} ?"
                content: Column(
                  children: [
                    Text(
                        "Apakah anda yakin akan melakukan presensi di ruang ini?"),
                    Text(
                      "Nama Ruang : ${hasilScanQr['data']['ruang']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text("Batal"),
                  ),
                  Obx(() => ElevatedButton(
                        onPressed: () async {
                          if (isLoading.value == false) {
                            isLoading.value = true;
                            Map<String, dynamic> dataResponse =
                                await determinePosition();
                            if (dataResponse["error"] != true) {
                              Position position = dataResponse["posisi"];

                              List<Placemark> placemarks =
                                  await placemarkFromCoordinates(
                                      position.latitude, position.longitude);
                              String address =
                                  "${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
                              await updatePosition(position, address);

                              String ruang = hasilScanQr['data']['ruang'];

                              double distance = Geolocator.distanceBetween(
                                  -1.3133071,
                                  102.1073423,
                                  position.latitude,
                                  position.longitude);

                              await presensiMasuk(
                                  position, address, ruang, distance);
                              Get.back();
                              Get.snackbar(
                                  "Berhasil", "Melakukan presensi masuk");
                              isLoading.value = false;
                            } else {
                              isLoading.value = false;
                              Get.snackbar(
                                  "Terjadi Kesalahan", dataResponse['message']);
                            }
                          }
                        },
                        child: Text(
                            isLoading.value == false ? "Yakin" : "Loading..."),
                      )),
                ],
              );
            } else {
              Get.snackbar("Terjadi Keasalahan", hasilScanQr['message']);
            }
          }
        }

        break;
      case 3:
        Get.offAllNamed(Routes.LIST_ABSEN);
        break;
      case 4:
        Get.offAllNamed(Routes.PROFIL);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }

  void cekHukuman() {
    var now = DateTime.now();
    var minutesAfter7am = now.hour * 60 + now.minute - (7 * 60 + 30);

    if (minutesAfter7am <= 10) {
      hukum = 'TL1';
    } else if (minutesAfter7am <= 20) {
      hukum = 'TL2';
    } else {
      hukum = 'TL3';
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return {
        "message":
            "Perangkat tidak dapat mendeteksi lokasi. Pastikan GPS aktif",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return {
          "message": "Aplikasi tidak diizinkan mendeteksi lokasi.",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Aplikasi tidak diizinkan mendeteksi lokasi. Ubah pengaturan di perangkat Anda",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      "posisi": position,
      "message": "Berhasil mendapatkan posisi",
      "error": false,
    };
  }

  Future<Map<String, dynamic>> getRuangan(String id) async {
    try {
      var hasil = await firestore.collection("ruangan").doc(id).get();

      if (hasil.data() != null) {
        return {
          "error": false,
          "message": "Berhasil mendapatkan data",
          "data": hasil.data()!,
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

  Future<void> presensiMasuk(
      Position position, String address, String ruang, double distance) async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference<Map<String, dynamic>> colPresensi =
        await firestore.collection("user").doc(uid).collection("presensi");
    CollectionReference<Map<String, dynamic>> tabelPresensi =
        await firestore.collection("presensi");
    QuerySnapshot<Map<String, dynamic>> snapPresensi = await colPresensi.get();

    String now = DateTime.now().toIso8601String();
    String nowid = "${DateTime.now().toIso8601String()}${uid}";

    Map<String, dynamic> userAbsen = await cekRole();

    String status = "Di Luar Area Sekolah";
    if (distance <= radiusMinimal) {
      status = "Di Dalam Area Sekolah";
    }

    await colPresensi.doc(now).set({
      "ruang": ruang,
      "date": now,
      "day": dayPresensi,
      "masuk": {
        "date": now,
        "lat": position.latitude,
        "long": position.longitude,
        "distance": distance,
        "alamat": address,
        "status": status,
      }
    });

    await tabelPresensi.doc(nowid).set({
      "nama": userAbsen['data']['nama'],
      "ruang": ruang,
      "date": now,
      "day": dayPresensi,
      "masuk": {
        "date": now,
        "lat": position.latitude,
        "long": position.longitude,
        "distance": distance,
        "alamat": address,
        "status": status,
      }
    });

    await firestore.collection("user").doc(uid).update({
      "status absen": now,
      "tabelUid": nowid,
      "id presen": now,
    });
  }

  Future<void> presensiKeluar(
      Position position, String address, String id, double distance) async {
    String uid = await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference<Map<String, dynamic>> colPresensi =
        await firestore.collection("user").doc(uid).collection("presensi");
    QuerySnapshot<Map<String, dynamic>> snapPresensi = await colPresensi.get();

    CollectionReference<Map<String, dynamic>> tabelPresensi =
        await firestore.collection("presensi");

    String now = DateTime.now().toIso8601String();
    Map<String, dynamic> userAbsen = await cekRole();
    String idPresensi = userAbsen['data']['tabelUid'];

    String status = "Di Luar Area Sekolah";
    if (distance <= radiusMinimal) {
      status = "Di Dalam Area Sekolah";
    }

    await colPresensi.doc(id).update({
      "keluar": {
        "date": now,
        "lat": position.latitude,
        "long": position.longitude,
        "distance": distance,
        "alamat": address,
        "status": status,
      }
    });

    await tabelPresensi.doc(idPresensi).update({
      "keluar": {
        "date": now,
        "lat": position.latitude,
        "long": position.longitude,
        "distance": distance,
        "alamat": address,
        "status": status,
      }
    });

    await firestore.collection("user").doc(uid).update({
      "status absen": FieldValue.delete(),
      "tabelUid": FieldValue.delete(),
    });
  }
}
