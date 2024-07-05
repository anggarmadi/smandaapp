import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/profil_controller.dart';
import '../../../controllers/page_admin_index_controller.dart';

class ProfilView extends GetView<ProfilController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
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
              padding: EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          user['profile'] != null && user['profile'] != ""
                              ? user['profile']
                              : defaultProfile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "${user['nama'].toString().toUpperCase()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "${user['nip']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                  },
                  leading: Icon(Icons.person),
                  title: Text("Update Profil"),
                ),
                SizedBox(height: 10),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.mail),
                  title: Text("${user['email']}"),
                ),
                SizedBox(height: 10),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_balance_sharp),
                  title: Text("${user['jabatan']}"),
                ),
                SizedBox(height: 10),
                ListTile(
                  onTap: () => controller.logout(),
                  leading: Icon(Icons.logout),
                  title: Text("Log Out"),
                ),
              ],
            );
          }),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Color(0xFF1EABE7),
        height: 60,
        items: [
          TabItem(icon: Icons.home, title: 'Beranda'),
          TabItem(
              icon: Icons.menu_book_rounded,
              title: pageC.role == "admin" ? 'Siswa' : "Telat"),
          TabItem(
              icon: pageC.role == "admin"
                  ? Icons.qr_code_scanner_rounded
                  : Icons.fingerprint_rounded,
              title: ''),
          TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) {
          if (pageC.role == "admin") {
            pageC.changePage(i);
          } else {
            pageC.changePageUser(i);
          }
        },
      ),
    );
  }
}
