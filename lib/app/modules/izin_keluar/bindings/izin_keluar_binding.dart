import 'package:get/get.dart';

import '../controllers/izin_keluar_controller.dart';

class IzinKeluarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinKeluarController>(
      () => IzinKeluarController(),
    );
  }
}
