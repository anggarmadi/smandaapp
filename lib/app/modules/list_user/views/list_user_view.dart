import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../controllers/list_user_controller.dart';

class ListUserView extends GetView<ListUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0FAFF),
        appBar: AppBar(
          title: const Text('Beranda'),
          centerTitle: true,
          backgroundColor: Color(0xFFF0FAFF),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streamUser(),
            builder: (context, snapshotUser) {
              if (snapshotUser.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshotUser.data == null ||
                  snapshotUser.data?.docs.length == 0) {
                return Center(
                  child: Text("Belum ada User"),
                );
              }
              return ListView.builder(
                  itemCount: snapshotUser.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        snapshotUser.data!.docs[index].data();
                    String defaultProfile =
                        "https://ui-avatars.com/api/?name=${data['nama']}";
                    String uidUser = data["uid"];
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.LIST_ABSEN,
                              arguments: uidUser),
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black26,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        data['profile'] != null &&
                                                data['profile'] != ""
                                            ? data['profile']
                                            : defaultProfile,
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nama : ${data['nama']}",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Jabatan/Tugas : ${data['jabatan']}",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}
