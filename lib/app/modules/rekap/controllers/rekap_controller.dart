import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RekapController extends GetxController {
  Stream<Map<String, int>> getJumlahData() async* {
    final stream = await FirebaseFirestore.instance
        .collection('keterlambatan')
        .where('status hukuman', whereIn: ['TL1', 'TL2', 'TL3']).snapshots();

    yield* stream.map((querySnapshot) {
      Map<String, int> data = {
        'TL1': 0,
        'TL2': 0,
        'TL3': 0,
      };

      for (var doc in querySnapshot.docs) {
        String statusHukuman = doc['status hukuman'];
        data[statusHukuman] = data[statusHukuman]! + 1;
      }

      return data;
    });
  }
}
