import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/list_izin_keluar_controller.dart';

class ListIzinKeluarView extends GetView<ListIzinKeluarController> {
  final pageC = Get.find<PageAdminIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('List Izin Keluar'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.IZIN_KELUAR),
              icon: Icon(Icons.add))
        ],
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
              String statusIzin = (listSiswa[index].data()
                  as Map<String, dynamic>)['tipe izin'];
              String? statusSiswa = (listSiswa[index].data()
                  as Map<String, dynamic>)['status siswa'];
              Color warnaStatus = Color(0xFFF9EB6E);
              if (statusIzin == "izin pulang") {
                warnaStatus = Color(0xFFFA656E);
              }
              if (statusSiswa == "sudah kembali") {
                warnaStatus = Color(0xFF38F3B0);
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
                  color: warnaStatus,
                ),
                child: Column(
                  children: [
                    Text("${statusIzin.toUpperCase()}"),
                    SizedBox(height: 10),
                    Row(
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
                                "Jam Keluar : ${(listSiswa[index].data() as Map<String, dynamic>)['jam izin']}",
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
                              if ((listSiswa[index].data() as Map<String,
                                      dynamic>)['kembali pada'] !=
                                  null)
                                Text(
                                  "Jam Kembali : ${(listSiswa[index].data() as Map<String, dynamic>)['kembali pada']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (pageC.role == "admin")
                          OutlinedButton(
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
                                      controller.hapusData(
                                          (listSiswa[index].data()
                                              as Map<String, dynamic>)['id']);
                                    },
                                    child: Text("Hapus"),
                                  ),
                                ],
                              );
                            },
                            child: Text("Hapus"),
                          ),
                        if (statusIzin == "izin sementara" &&
                            statusSiswa != "sudah kembali")
                          ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Perhatian",
                                middleText:
                                    "Apakah ${(listSiswa[index].data() as Map<String, dynamic>)['nama']} sudah kembali ke sekolah?",
                                actions: [
                                  OutlinedButton(
                                    onPressed: () => Get.back(),
                                    child: Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.updateIzin(
                                          (listSiswa[index].data()
                                              as Map<String, dynamic>)['id']);
                                    },
                                    child: Text("Selesai"),
                                  ),
                                ],
                              );
                            },
                            child: Text("Selesai"),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
