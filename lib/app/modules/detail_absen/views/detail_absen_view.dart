import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_absen_controller.dart';

class DetailAbsenView extends GetView<DetailAbsenController> {
  Map<String, dynamic> data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Detail Absen'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "${DateFormat.yMMMMEEEEd().format(DateTime.parse(data['date']))}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Center(child: Text(data['ruang'])),
                SizedBox(height: 20),
                Text(
                  "Masuk",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    "Jam  : ${DateFormat.jms().format(DateTime.parse(data['masuk']['date']))}"),
                Text(
                    "Koordinat  : ${data['masuk']['lat']}, ${data['masuk']['long']}"),
                Text(
                    "Status  : ${NumberFormat('###.0#', 'en_US').format(data['masuk']['distance'])} m"),
                Text("Status  : ${data['masuk']['status']}"),
                SizedBox(height: 20),
                Text(
                  "Keluar",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (data['keluar'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Jam  : ${DateFormat.jms().format(DateTime.parse(data['keluar']['date']))}"),
                      Text(
                          "Koordinat  : ${data['keluar']['lat']}, ${data['keluar']['long']}"),
                      Text(
                          "Status  : ${NumberFormat('###.0#', 'en_US').format(data['keluar']['distance'])} m"),
                      Text("Status  : ${data['keluar']['status']}"),
                    ],
                  ),
                if (data['keluar'] == null) Text("     -"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
