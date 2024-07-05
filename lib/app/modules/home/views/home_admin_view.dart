import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:smandaapp/app/modules/home/controllers/home_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../../../controllers/page_admin_index_controller.dart';

class HomeAdminView extends GetView<HomeController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Beranda'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                Map<String, dynamic> user = snapshot.data!.data()!;
                String defaultProfile =
                    "https://ui-avatars.com/api/?name=${user['nama']}";
                return ListView(
                  children: [
                    Container(
                      // alignment: Alignment.center,
                      width: Get.width * 0.4,
                      height: Get.width * 0.4,
                      child: Image.asset("assets/logo/smanda.png"),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                10.0), // Change this to adjust corner radius
                          ),
                          width: Get.width,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black26,
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  user['profile'] != null &&
                                          user['profile'] != ""
                                      ? user['profile']
                                      : defaultProfile,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Text(
                                    "${user['nama'].toString()}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${user['nip'].toString()}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${user['jabatan'].toString()}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Menu Smanda App",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.LIST_KETERLAMBATAN);
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: Get.width * 0.42,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Change this to adjust corner radius
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.menu_book_sharp),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Terlambat",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(Routes.LIST_IZIN_KELUAR),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: Get.width * 0.42,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Change this to adjust corner radius
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.logout_outlined),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Izin Keluar",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.LIST_USER);
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: Get.width * 0.42,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Change this to adjust corner radius
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Daftar User",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ADD_USER);
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: Get.width * 0.42,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Change this to adjust corner radius
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.person_add),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "User Baru",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Color(0xFF1EABE7),
        height: 60,
        items: [
          TabItem(icon: Icons.home, title: 'Beranda'),
          TabItem(icon: Icons.menu_book_rounded, title: 'Siswa'),
          TabItem(icon: Icons.qr_code_scanner_rounded, title: 'Qr'),
          TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
