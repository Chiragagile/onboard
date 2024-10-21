import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/auth/forgotpassword/controller/forgot_controller.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({super.key});

  final ForgotController _controller = Get.put(ForgotController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallSpace(),
                      forgotTextWidget(),
                      smallSpace(),
                      emailTextField(),
                      smallSpace(),
                      submitButtonWidget(),
                      smallSpace(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotTextWidget() {
    return textWidget(
        text: forgotPasswordHeadText,
        fontSize: 22.0,
        fontWeight: FontWeight.bold);
  }

  Widget emailTextField(){
    return emailTextFormFieldWithBorder(
        controller: _controller.emailController,
        label: "E-mail",
        validator: (value){
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if(value == null || value.isEmpty){
            return pleaseEnterYourEmailIdText;
          }
          else if(!emailRegex.hasMatch(value)){
            return pleaseEnterCorrectEmailIdText;
          }
          else {
            return null;
          }
      }
    );
  }

  Widget submitButtonWidget() {
    return customRaisedButton(
      onPressed: () {
        if (formKey.currentState!.validate() ) {
          _controller.forgotPasswordApi();
        }
      },
      text: submitText,
      radius: 80.0,
      textColor: blackTextColor,
      height: Get.height * 0.07,);
  }
}
