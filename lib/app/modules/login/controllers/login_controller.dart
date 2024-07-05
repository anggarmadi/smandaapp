import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  RxBool isHiden = true.obs;
  RxBool isLoading = false.obs;
  String dayPresensi =
      "${DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-")}";

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );
        print(userCredential);
        if (userCredential != null) {
          if (userCredential.user!.emailVerified == true) {
            if (passC.text != "smandate") {
              Get.offAllNamed(Routes.HOME);
            } else {
              Get.offAllNamed(Routes.GANTI_PASSOWORD);
            }
          } else {
            Get.defaultDialog(
                title: "Belum Verifikasi",
                middleText:
                    "Akun anda belum diverifikasi. Silahkan lakukan verifikasi akun Anda. Cek Email Anda",
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      isLoading.value = false;
                      Get.back();
                    },
                    child: Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await userCredential.user!.sendEmailVerification();
                        Get.back();
                        Get.snackbar(
                          "Sukses",
                          "Berhasil mengirimkan, silahkan cek email Anda",
                        );
                        isLoading.value = false;
                      } catch (e) {
                        Get.snackbar(
                          "Terjadi Kesalahan",
                          "Tidak dapat mengirimkan email verifikasi, hubungi Admin",
                        );
                        isLoading.value = false;
                      }
                    },
                    child: Text("Kirim Ulang"),
                  )
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;

          print('No user found for that email.');
          Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
          isLoading.value = false;

          print('Wrong password provided for that user.');
          Get.snackbar("Terjadi Kesalahan", "Password salah");
        } else {
          isLoading.value = false;

          Get.snackbar(
              "Terjadi Kesalahan", "Pastikan Email dan Password Sudah benar");
        }
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Email dan Password wajib diisi");
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
