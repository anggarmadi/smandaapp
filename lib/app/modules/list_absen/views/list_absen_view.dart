import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/list_absen_controller.dart';

class ListAbsenView extends GetView<ListAbsenController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('List Absen'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamAbsen(),
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
            if (snapshot.data == null || snapshot.data?.docs.length == 0) {
              return Center(
                child: Text("Belum ada histori presensi"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () =>
                          Get.toNamed(Routes.DETAIL_ABSEN, arguments: data),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${data['ruang']}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Masuk",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "${DateFormat.jms().format(DateTime.parse(data['masuk']['date']))}",
                                        style: TextStyle(),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Keluar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        data['keluar'] != null
                                            ? "${DateFormat.jms().format(DateTime.parse(data['keluar']['date']))}"
                                            : "     -",
                                        style: TextStyle(),
                                      ),
                                    ]),
                                Text(
                                  "${DateFormat.MMMMEEEEd().format(DateTime.parse(data['date']))}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
      bottomNavigationBar:
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> user = snapshot.data!.data()!;
          if (user['role'] != "admin") {
            return ConvexAppBar(
              style: TabStyle.fixedCircle,
              backgroundColor: Color(0xFF1EABE7),
              height: 60,
              items: [
                TabItem(icon: Icons.home, title: 'Beranda'),
                TabItem(icon: Icons.menu_book_rounded, title: 'Telat'),
                TabItem(icon: Icons.fingerprint, title: ''),
                TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
                TabItem(icon: Icons.people, title: 'Profil'),
              ],
              initialActiveIndex: pageC.pageIndex.value,
              onTap: (int i) => pageC.changePageUser(i),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
