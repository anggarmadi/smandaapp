import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ganti_passoword_controller.dart';

class GantiPassowordView extends GetView<GantiPassowordController> {
  const GantiPassowordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Ganti Password'),
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
          Obx(
            () => TextField(
              autocorrect: false,
              controller: controller.newPassC,
              obscureText: controller.isHiden.value,
              decoration: InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHiden.toggle();
                  },
                  icon: Icon(Icons.remove_red_eye),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              controller.changePass();
            },
            child: Text("Ganti Password"),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF1EABE7)),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
            ),
          ),
        ],
      ),
    );
  }
}
