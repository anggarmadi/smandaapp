import 'package:get/get.dart';

import '../controllers/list_izin_keluar_controller.dart';

class ListIzinKeluarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListIzinKeluarController>(
      () => ListIzinKeluarController(),
    );
  }
}
