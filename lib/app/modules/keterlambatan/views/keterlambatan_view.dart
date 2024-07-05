import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/keterlambatan_controller.dart';

class KeterlambatanView extends GetView<KeterlambatanController> {
  final Map<String, dynamic> data = Get.arguments;
  var format = DateFormat.jm();
  var formatId = DateFormat.yMd();
  @override
  Widget build(BuildContext context) {
    String date = "${formatId.format(DateTime.now()).toString()}";
    date = date.replaceAll("/", "-");
    controller.id = "${data['nisn']}$date";
    controller.nama = data['nama siswa'];
    controller.nisn = data['nisn'];
    controller.kelas = data['kelas'];
    controller.kedatangan = DateTime.now().toIso8601String();
    controller.hukum = data['hukum'];
    Color hasil = Colors.black;
    if (data['hukum'] == "TL1") {
      hasil = Colors.black;
    } else if (data['hukum'] == "TL2") {
      hasil = Colors.amber.shade700;
    } else {
      hasil = Colors.red.shade900;
    }
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Keterlambatan Siswa'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: ListView(
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
                    "https://ui-avatars.com/api/?name=${data['nama siswa']}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  10.0), // Change this to adjust corner radius
            ),
            width: Get.width,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Nama",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          ":",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${data['nama siswa']}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "NISN",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 35),
                        Text(
                          ":",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${data['nisn']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Kelas",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 32),
                        Text(
                          ":",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${data['kelas']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Datang",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          ":",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${format.format(DateTime.now())}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                Text(
                  "${data['hukum']}",
                  style: TextStyle(
                    color: hasil,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.deskC,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                await controller.kirimLaporan();
              },
              child:
                  Text(controller.isLoading.isFalse ? "Kirim" : "Loading..."),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF1EABE7)),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
