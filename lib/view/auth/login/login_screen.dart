import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/auth/login/controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _controller = Get.put(LoginController());
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
                      loginTextWidget(),
                      smallSpace(),
                      usernameWidget(),
                      smallSpace(),
                      passwordWidget(),
                      const SizedBox(height: 5,),
                      forgotPasswordTextWidget(),
                      smallSpace(),
                      signInButtonWidget(),
                      smallSpace(),
                      signupTextWidget()
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

  Widget loginTextWidget() {
    return textWidget(
        text: loginYourAccountText,
        fontSize: 22.0,
        fontWeight: FontWeight.bold);
  }

  Widget usernameWidget() {
    return normalTextFormFieldWithBorder(
      controller: _controller.usernameController,
      label: usernameText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return pleaseEnterYourUsernameText;
        }
        return null;
      },
    );
  }

  Widget passwordWidget() {
    return normalTextFormFieldWithBorder(
      controller: _controller.passwordController,
      label: passwordText,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return pleaseEnterYourPasswordText;
        }
        return null;
      },
    );
  }

  Widget signInButtonWidget() {
    return customRaisedButton(
      onPressed: () {
        if (formKey.currentState!.validate() ) {
            _controller.loginApi();
        // Get.offAllNamed(RouteManagement.dashboardScreen);
        }
      },
      text: loginText,
      radius: 80.0,
      textColor: blackTextColor,
      height: Get.height * 0.07,);
  }

  Widget signupTextWidget(){
    return RichText(
      text: TextSpan(
        children: [
         const TextSpan(
            text: dontHaveanAccountText,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: signupText,
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle the tap event
                Get.offAllNamed(RouteManagement.signupScreen);
              },
          ),
        ],
      ),
    );
  }

  Widget forgotPasswordTextWidget(){
    return GestureDetector(
      onTap: (){
          Get.toNamed(RouteManagement.forgotScreen);
      },
        child: Align(
          alignment:Alignment.bottomRight,
            child: textWidget(text: forgotPasswordText ,textColor: Colors.blue.shade300))
    );
  }
}
