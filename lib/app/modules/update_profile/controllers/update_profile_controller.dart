import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smandaapp/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController nipC = TextEditingController();
  TextEditingController namaC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (emailC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        namaC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        Map<String, dynamic> data = {
          "nama": namaC.text,
        };
        if (image != null) {
          File file = File(image!.path);
          String ext = image!.name.split(".").last;

          await storage.ref('${namaC.text}/profil.$ext').putFile(file);
          String ulrImage =
              await storage.ref('${namaC.text}/profil.$ext').getDownloadURL();

          print(ulrImage);

          data.addAll({
            "profile": ulrImage,
          });
        }
        print(data);
        await firestore.collection("user").doc(uid).update(data);
        Get.snackbar("Berhasil", "Berhasil mengupdate profil");
        Get.offAllNamed(Routes.PROFIL);
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Gagal mengupdate profil");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
