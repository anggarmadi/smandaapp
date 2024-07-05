import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  TextEditingController namaC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController jabatanC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController adminPassC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  RxBool isLoadingAdd = false.obs;

  Future<void> prossesAddPengguna() async {
    isLoadingAdd.value = true;
    if (adminPassC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;
        UserCredential adminCredential = await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: adminPassC.text,
        );

        final credential = await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "smandate",
        );

        if (credential.user != null) {
          String uid = credential.user!.uid;

          await firestore.collection("user").doc(uid).set({
            "nama": namaC.text,
            "nip": nipC.text,
            "jabatan": jabatanC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "user",
            "createdAt": DateTime.now().toIso8601String(),
          });

          await credential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential adminCredential =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: adminPassC.text,
          );

          Get.back(); //tutup dialog
          Get.back(); //tutup add pengguna
          Get.snackbar("Sukses", "Berhasil menambahkan pengguna");
          isLoadingAdd.value = false;
        }
      } on FirebaseAuthException catch (e) {
        isLoadingAdd.value = false;
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Get.snackbar("Terajadi Kesalahan", "Email sudah terdaftar");
        } else if (e.code == 'invalid-credential') {
          Get.snackbar("Terajadi Kesalahan", "Password Admin Salah");
        } else {
          Get.snackbar("Terajadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        isLoadingAdd.value = false;
        print("Errornya : $e");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Terjadi Kesalahan", "Password Admin wajib diisi");
    }
  }

  Future<void> addPengguna() async {
    if (namaC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        jabatanC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      Get.defaultDialog(
          title: "Validasi Admin",
          content: Column(
            children: [
              Text("Masukan password untuk validasi admin"),
              SizedBox(height: 10),
              TextField(
                controller: adminPassC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                isLoading.value = false;
                Get.back();
              },
              child: Text("Tutup"),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  if (isLoadingAdd.isFalse) {
                    await prossesAddPengguna();
                  }
                  isLoading.value = false;
                },
                child: Text(isLoadingAdd.isFalse ? "Kirim" : "Loading..."),
              ),
            )
          ]);
    } else {
      Get.snackbar("Terajadi Kesalahan",
          "Pastikan seluruh data telah terisi dengan benar");
      isLoading.value = false;
    }
  }
}
