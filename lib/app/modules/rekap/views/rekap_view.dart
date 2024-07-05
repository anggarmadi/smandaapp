import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';

import '../controllers/rekap_controller.dart';
import '../../../controllers/page_admin_index_controller.dart';

class RekapView extends GetView<RekapController> {
  final pageC = Get.find<PageAdminIndexController>();
  @override
  Widget build(BuildContext context) {
    double ukuran = 120;
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Rekap'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: StreamBuilder<Map<String, int>>(
          stream: controller.getJumlahData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int total = snapshot.data!['TL1']! +
                  snapshot.data!['TL2']! +
                  snapshot.data!['TL3']!;
              // Tampilkan data
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Total Data",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${total.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 250,
                          height: 250,
                          child: Center(
                              child: PieChart(PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Color(0xFF38F3B0),
                                value: snapshot.data!['TL1']!.toDouble(),
                                radius: ukuran,
                                title: '${snapshot.data!['TL1']}',
                              ),
                              PieChartSectionData(
                                color: Color(0xFFF9EB6E),
                                value: snapshot.data!['TL2']!.toDouble(),
                                radius: ukuran,
                                title: '${snapshot.data!['TL2']}',
                              ),
                              PieChartSectionData(
                                color: Color(0xFFFA656E),
                                value: snapshot.data!['TL3']!.toDouble(),
                                radius: ukuran,
                                title: '${snapshot.data!['TL3']}',
                              ),
                            ],
                            centerSpaceRadius: 0,
                          ))),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Color(0xFF38F3B0)),
                                  SizedBox(width: 10),
                                  Text("TL1")
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Color(0xFFF9EB6E)),
                                  SizedBox(width: 10),
                                  Text("TL2")
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Color(0xFFFA656E)),
                                  SizedBox(width: 10),
                                  Text("TL3")
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // Tampilkan pesan error
              return Text('Error: ${snapshot.error}');
            } else {
              // Tampilkan loading indicator
              return CircularProgressIndicator();
            }
          }),
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
