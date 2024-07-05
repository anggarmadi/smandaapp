import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smandaapp/app/modules/home/views/home_admin_view.dart';
import 'package:smandaapp/app/modules/home/views/home_user_view.dart';

import '../controllers/home_controller.dart';
import '../../../controllers/page_admin_index_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    pageC.cekRole();
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: controller.streamRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        String role = snapshot.data!.data()!["role"];
        if (role == "admin") {
          return HomeAdminView();
          //apa
        } else {
          return HomeUserView();
          //apa
        }
      },
    );
  }
}
