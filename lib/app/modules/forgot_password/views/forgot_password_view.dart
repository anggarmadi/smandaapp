import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Text(
              "Lupa Pasword",
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
              width: 130,
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
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  controller.isLoading.value = true;
                  await controller.resetPass();
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "Reset Password"
                  : "Loading..."),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF1EABE7)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
