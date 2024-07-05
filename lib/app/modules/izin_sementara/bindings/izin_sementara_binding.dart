import 'package:get/get.dart';

import '../controllers/izin_sementara_controller.dart';

class IzinSementaraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IzinSementaraController>(
      () => IzinSementaraController(),
    );
  }
}
