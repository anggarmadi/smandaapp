import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';

import '../controllers/daftar_siswa_controller.dart';
import '../../../controllers/page_admin_index_controller.dart';

class DaftarSiswaView extends GetView<DaftarSiswaController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Data Siswa'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Search",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: controller.streamSiswa(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    var listSiswa = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: listSiswa.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    "https://ui-avatars.com/api/?name=${(listSiswa[index].data() as Map<String, dynamic>)['nama siswa']}"),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${(listSiswa[index].data() as Map<String, dynamic>)['nama siswa']}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "${(listSiswa[index].data() as Map<String, dynamic>)['nisn']}",
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Color(0xFF1EABE7),
        height: 60,
        items: [
          TabItem(icon: Icons.home, title: 'Beranda'),
          TabItem(icon: Icons.menu_book_rounded, title: 'Siswa'),
          TabItem(icon: Icons.qr_code_scanner_rounded, title: ''),
          TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
