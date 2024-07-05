import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smandaapp/app/controllers/page_admin_index_controller.dart';
import 'package:smandaapp/app/routes/app_pages.dart';

class ProfilController extends GetxController {
  final pageC = Get.find<PageAdminIndexController>();
  void logout() async {
    await FirebaseAuth.instance.signOut();
    pageC.pageIndex.value = 0;
    Get.offAllNamed(Routes.LOGIN);
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = auth.currentUser!.uid;

    yield* firestore.collection("user").doc(uid).snapshots();
  }
}
