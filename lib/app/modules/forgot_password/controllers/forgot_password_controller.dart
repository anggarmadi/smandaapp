import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> resetPass() async {
    if (emailC.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);

        Get.snackbar("Berhasil", "Silahkan cek email Anda");
        Get.offAllNamed(Routes.LOGIN);
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan",
            "Tidak dapat mengirimkan email reset password.");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email tidak wajib diisi");
      isLoading.value = false;
    }
  }
}
