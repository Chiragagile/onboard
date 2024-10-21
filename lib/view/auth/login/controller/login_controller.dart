import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/api/api.dart';
import 'package:onboard/api/dio.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/common_methods.dart';

class LoginController extends GetxController{

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginApi() async {
    Map<String, dynamic> data;
    data = {
      'username': usernameController.text.trim().toString(),
      'password': passwordController.text.trim().toString(),
    };
    print(API.login);
    print("Request is $data");
    GetDio.getDio(true).post(API.login, data: data).then((response) {
      print("Response $response");
      print("Token is ${response.data['token']}");
      if (response.statusCode == 200) {
        getStorage.write('isLogin', true);
        getStorage.write('token', response.data['token']);
        Get.offAllNamed(RouteManagement.dashboardScreen);
        update();
      }
      else {
        Get.showSnackbar(snackBarWidget(
            title: "Error",
            message: response.data["message"].toString(),
            icon: Icons.error,
            iconColor: Colors.red));
      }
    });
  }

  // Future<void> loginApi() async {
  //   Dio dio = Dio();
  //
  //   try {
  //     var response = await dio.post(
  //       'http://192.168.1.100:443/api/users/login',  // Replace with correct IP and port
  //       data: {
  //         'username': usernameController.text.toString(),
  //         'password': passwordController.text.toString(),
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //     );
  //     print('Response data: ${response.data}');
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       print('DioError [${e.response?.statusCode}]: ${e.response?.data}');
  //     } else {
  //       print('Error sending request: $e');
  //     }
  //   }
  // }

}