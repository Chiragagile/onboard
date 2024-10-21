import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/common_methods.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if(getStorage.read('isLogin') ?? false){
        Get.offAllNamed(RouteManagement.dashboardScreen);
      }
      else{
        Get.offAllNamed(RouteManagement.loginScreen);
      }
    });
    super.onInit();
  }


}