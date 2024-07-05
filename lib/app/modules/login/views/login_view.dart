import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        // title: const Text('Login'),
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
          SizedBox(height: 20),
          Center(
            child: Text(
              "Log In",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.black,
              height: 1.5,
              width: 65,
            ),
          ),
          SizedBox(height: 50),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(Icons.mail),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => TextField(
              autocorrect: false,
              controller: controller.passC,
              obscureText: controller.isHiden.value,
              decoration: InputDecoration(
                labelText: "Password",
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
          SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.login();
                }
              },
              child:
                  Text(controller.isLoading.isFalse ? "Log In" : "Loading..."),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF1EABE7)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
            child: Text("Lupa Pasword?"),
          )
        ],
      ),
    );
  }
}
