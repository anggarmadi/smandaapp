import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class GantiPassowordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isHiden = true.obs;

  void changePass() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "smandate") {
        try {
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );

          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar("Terjadi Kesalahan",
                "Password minimal terdiri atas 6 karakter!!");
          }
        }
      } else {
        Get.snackbar("Terjadi Kesalahan",
            "Pastikan password baru berbeda dari password sebelumnya");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password baru wajib diisi");
    }
  }
}
