import 'package:get/get.dart';

import '../controllers/ganti_passoword_controller.dart';

class GantiPassowordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GantiPassowordController>(
      () => GantiPassowordController(),
    );
  }
}
