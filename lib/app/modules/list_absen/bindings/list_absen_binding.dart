import 'package:get/get.dart';

import '../controllers/list_absen_controller.dart';

class ListAbsenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListAbsenController>(
      () => ListAbsenController(),
    );
  }
}
