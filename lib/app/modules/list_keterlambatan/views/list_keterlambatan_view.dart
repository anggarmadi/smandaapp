import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/list_keterlambatan_controller.dart';

class ListKeterlambatanView extends GetView<ListKeterlambatanController> {
  final pageC = Get.find<PageAdminIndexController>();

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.jm();
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('List Keterlambatan'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamLaporan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var listSiswa = snapshot.data!.docs;
          print(listSiswa);
          if (listSiswa.length == 0) {
            return const Center(
              child: Text("Tidak Ada Data"),
            );
          }

          return ListView.builder(
            itemCount: listSiswa.length,
            itemBuilder: (context, index) {
              String hukuman = (listSiswa[index].data()
                  as Map<String, dynamic>)['status hukuman'];
              Color warnaHukuman = Color(0xFF38F3B0);
              if (hukuman == "TL2") {
                warnaHukuman = Color(0xFFF9EB6E);
              }
              if (hukuman == "TL3") {
                warnaHukuman = Color(0xFFFA656E);
              }

              return Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: warnaHukuman,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://ui-avatars.com/api/?name=${(listSiswa[index].data() as Map<String, dynamic>)['nama']}"),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(listSiswa[index].data() as Map<String, dynamic>)['nama']}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${format.format(DateTime.parse((listSiswa[index].data() as Map<String, dynamic>)['kedatangan']))} (${(listSiswa[index].data() as Map<String, dynamic>)['status hukuman']})",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "Kelas ${(listSiswa[index].data() as Map<String, dynamic>)['kelas']}",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "Alasan : ${(listSiswa[index].data() as Map<String, dynamic>)['deskripsi']}",
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (pageC.role == "admin")
                      IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Perhatian",
                            middleText:
                                "Apakah anda yakin akan menghapus data ini",
                            actions: [
                              OutlinedButton(
                                onPressed: () => Get.back(),
                                child: Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.hapusData((listSiswa[index].data()
                                      as Map<String, dynamic>)['id']);
                                },
                                child: Text("Hapus"),
                              ),
                            ],
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
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
