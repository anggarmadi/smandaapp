import 'package:get/get.dart';

import '../controllers/list_keterlambatan_controller.dart';

class ListKeterlambatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListKeterlambatanController>(
      () => ListKeterlambatanController(),
    );
  }
}
