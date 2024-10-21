import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/api/api.dart';
import 'package:onboard/api/dio.dart';
import 'package:onboard/utils/common_methods.dart';

class ForgotController extends GetxController{

  TextEditingController emailController = TextEditingController();


  void forgotPasswordApi() async {
    Map<String, dynamic> data;
    data = {
      "mail":emailController.text.toString(),
    };
    print(API.forgotPassword);
    print("Request  $data");
    GetDio.getDio(true).post(API.forgotPassword, data: data).then((response) {
      print("Response $response");
      if (response.statusCode == 200) {
        emailController.clear();
        print("Response is $response");
        Get.showSnackbar(snackBarWidget(
            title: "",
            message: response.data["message"].toString(),
            icon: Icons.check_rounded,
            iconColor: Colors.green));
        update();
      } else {
        Get.showSnackbar(snackBarWidget(
            title: "Error",
            message: response.data["message"].toString(),
            icon: Icons.error,
            iconColor: Colors.red));
      }
    });
  }


}