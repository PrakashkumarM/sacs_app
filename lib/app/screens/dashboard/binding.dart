import 'package:get/get.dart';
import 'package:sacs_app/app/screens/dashboard/controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
