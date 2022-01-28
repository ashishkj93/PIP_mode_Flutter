import 'package:flutter_pip_example/controllers/pip_controller.dart';
import 'package:get/get.dart';


class BindingController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PipVideoController(), fenix: true);
  }
}
