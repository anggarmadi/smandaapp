import 'package:get/get.dart';

import '../controllers/izin_pulang_controller.dart';

class IzinPulangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinPulangController>(
      () => IzinPulangController(),
    );
  }
}
