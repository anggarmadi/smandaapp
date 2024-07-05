import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:smandaapp/app/modules/home/controllers/home_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

import '../../../controllers/page_admin_index_controller.dart';

import 'package:get/get.dart';

class HomeUserView extends GetView<HomeController> {
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user['nama'].toString()}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      user['alamat'] != null
                                          ? "${user['alamat']}"
                                          : "Belum ada lokasi",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: controller.streamAbsenToday(),
                            builder: (context, snapshotToday) {
                              if (snapshotToday.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              Map<String, dynamic>? dataToday =
                                  snapshotToday.data?.data();

                              return Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () => Get.toNamed(Routes.DETAIL_ABSEN,
                                      arguments: dataToday),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Change this to adjust corner radius
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Masuk"),
                                              Text(dataToday?['masuk'] == null
                                                  ? "-"
                                                  : "${DateFormat.jms().format(DateTime.parse(dataToday?['masuk']['date']))}"),
                                            ],
                                          ),
                                          Container(
                                            width: 2,
                                            height: 40,
                                            color: Colors.grey,
                                          ),
                                          Column(
                                            children: [
                                              Text("Keluar"),
                                              Text(dataToday?['keluar'] == null
                                                  ? "-"
                                                  : "${DateFormat.jms().format(DateTime.parse(dataToday?['keluar']['date']))}"),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            }),
                        SizedBox(height: 30),
                        ListTile(
                          onTap: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#FFFFFF", "Batal", true, ScanMode.QR);
                            if (barcodeScanRes != null) {
                              Map<String, dynamic> hasil =
                                  await pageC.getSiswabyNisn(barcodeScanRes);
                              hasil['data']['hukum'] = pageC.hukum;

                              if (hasil['error'] == false) {
                                Get.toNamed(Routes.KETERLAMBATAN,
                                    arguments: hasil['data']);
                              } else {
                                Get.snackbar(
                                    "Terjadi Keasalahan", hasil['message']);
                              }
                            }
                          },
                          leading: Icon(Icons.qr_code_scanner_rounded),
                          title: Text("Lapor Keterlambatan"),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: () => Get.toNamed(Routes.LIST_IZIN_KELUAR),
                          leading: Icon(Icons.book_outlined),
                          title: Text("Menu Izin Keluar"),
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
          TabItem(icon: Icons.menu_book_rounded, title: 'Telat'),
          TabItem(icon: Icons.fingerprint, title: ''),
          TabItem(icon: Icons.filter_none_rounded, title: 'Rekap'),
          TabItem(icon: Icons.people, title: 'Profil'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePageUser(i),
      ),
    );
  }
}
