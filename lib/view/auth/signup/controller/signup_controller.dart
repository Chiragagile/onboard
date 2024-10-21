import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboard/api/api.dart';
import 'package:onboard/api/dio.dart';
import 'package:onboard/utils/common_methods.dart';

class SignupController extends GetxController{
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController alternateNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> userTypeDropdownItems = <String>['HR','Manager'];
  RxString userTypeValue = 'HR'.obs;

  var selectedImage = Rx<File?>(null);
  XFile? pickedFile;

  final ImagePicker _picker = ImagePicker();


  Future<void> pickImage() async {
    pickedFile = await Get.bottomSheet(
      Container(
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                Get.back(result: image);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                Get.back(result: image);
              },
            ),
          ],
        ),
      ),
    );

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile!.path);
    }
  }

  void signupApi() async {
    Map<String, dynamic> data;
    data = {
      "username":usernameController.text.toString(),
      "password":passwordController.text.toString(),
      "mail":emailController.text.toString(),
      "mobile1": contactNoController.text.toString(),
      "user_role" : userTypeValue.value.toString(),
      "name": nameController.text.toString(),
      "gender": "",
      "mobile2": alternateNoController.text.toString()
    };
    print(API.signup);
    print("Request  $data");
    GetDio.getDio(true).post(API.signup, data: data).then((response) {
      print("Response $response");
      if (response.statusCode == 200) {
        clearValues();
        print("Response is $response");
        Get.showSnackbar(snackBarWidget(
            title: "Success",
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

  clearValues(){
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    contactNoController.clear();
    nameController.clear();
    alternateNoController.clear();
  }

}