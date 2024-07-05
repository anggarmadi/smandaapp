import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.namaC.text = user['nama'];
    controller.emailC.text = user['email'];
    controller.nipC.text = user['nip'];
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Update Profil'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            // alignment: Alignment.center,
            width: Get.width * 0.2,
            height: Get.width * 0.2,
            child: Image.asset("assets/logo/logos.png"),
          ),
          SizedBox(height: 50),
          TextField(
            controller: controller.namaC,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.emailC,
            autocorrect: false,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.mail),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: controller.nipC,
            autocorrect: false,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Nip",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.perm_contact_cal),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Foto Profil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user['profile'] != null) {
                      return ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            user['profile'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Text("Choose");
                    }
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  controller.pickImage();
                },
                child: Text("Choose"),
              ),
            ],
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
                onPressed: () async {
                  await controller.updateProfile(user['uid']);
                },
                child: Text(controller.isLoading.isFalse
                    ? "Update Profil"
                    : "Loading..."),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF1EABE7)),
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
                ),
              )),
        ],
      ),
    );
  }
}
