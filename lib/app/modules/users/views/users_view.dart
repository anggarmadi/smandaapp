import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/users_controller.dart';
import '../../../controllers/page_admin_index_controller.dart';

class UsersView extends GetView<UsersController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Data Pengguna'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_USER);
        },
        backgroundColor: Color(0xFF1EABE7),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: const Center(
        child: Text(
          'DaftarSiswaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Color(0xFF1EABE7),
        height: 60,
        items: [
          TabItem(icon: Icons.home, title: 'Beranda'),
          TabItem(icon: Icons.menu_book_rounded, title: 'Siswa'),
          TabItem(icon: Icons.fingerprint, title: ''),
          TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
