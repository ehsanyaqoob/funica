import 'package:funica/Screens/navbar/navbar-screen.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:get/get.dart';
import 'package:funica/controller/profile-data-cont.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FillUpProfileController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}

class NavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavController(), fenix: true);
    Get.lazyPut(() => FillUpProfileController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}