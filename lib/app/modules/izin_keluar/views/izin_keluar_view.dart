import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/izin_keluar_controller.dart';

class IzinKeluarView extends GetView<IzinKeluarController> {
  const IzinKeluarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0FAFF),
      appBar: AppBar(
        title: const Text('Menu Izin Keluar'),
        centerTitle: true,
        backgroundColor: Color(0xFFF0FAFF),
      ),
      body: ListView(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  controller.ScanIzinSementara();
                },
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.motorcycle_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Izin Keluar Sementara",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            padding: const EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  controller.ScanIzinPulang();
                },
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emergency),
                        SizedBox(width: 10),
                        Text(
                          "Izin Pulang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
