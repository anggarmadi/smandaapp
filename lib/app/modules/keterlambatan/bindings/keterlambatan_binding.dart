import 'package:get/get.dart';

import '../controllers/keterlambatan_controller.dart';

class KeterlambatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeterlambatanController>(
      () => KeterlambatanController(),
    );
  }
}
