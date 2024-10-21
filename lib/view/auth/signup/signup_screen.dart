import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/auth/signup/controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

   final SignupController _controller = Get.put(SignupController());
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
                        signupTextWidget(),
                        smallSpace(),
                        userImageWidget(),
                        smallSpace(),
                        usernameWidget(),
                        const SizedBox(height: 5,),
                        usernameInstructionWidget(),
                        smallSpace(),
                        nameWidget(),
                        smallSpace(),
                        contactNumber(),
                        smallSpace(),
                        alternateNumber(),
                        smallSpace(),
                        emailTextField(),
                        smallSpace(),
                        passwordWidget(),
                        smallSpace(),
                        userTypeDropdown(),
                        smallSpace(),
                        signupButtonWidget(),
                        smallSpace(),
                        signinTextWidget(),
                        smallSpace()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

   Widget signupTextWidget() {
     return textWidget(
         text: signupYourAccountText,
         fontSize: 22.0,
         fontWeight: FontWeight.bold);
   }

   Widget userImageWidget(){
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controller.selectedImage.value != null
              ? Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _controller.selectedImage.value!,
                fit: BoxFit.cover, // Ensures the image covers the container
              ),
            ),
          )
              : Container(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _controller.pickImage();
            },
            child: const Text(uploadPictureText),
          ),
        ],
      );
    });
   }

   Widget usernameWidget() {
     return normalTextFormFieldWithBorder(
       controller: _controller.usernameController,
       label: usernameText,
       validator: (value){
         // Check if value is null or empty
         if (value == null || value.isEmpty) {
           return pleaseEnterYourUsernameText;
         }
         final RegExp usernameRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
         if (!usernameRegExp.hasMatch(value)) {
           return pleaseEnterCorrectUsernameText;
         }
         return null;
       }
     );
   }

   Widget nameWidget() {
     return normalTextFormFieldWithBorder(
         controller: _controller.nameController,
         label: "Name",
         validator: (value){
           // Check if value is null or empty
           if (value == null || value.isEmpty) {
             return pleaseEnterYourNameText;
           }
           return null;
         }
     );
   }

   Widget usernameInstructionWidget() {
     return textWidget(
      text:  pleaseEnetrAtLeast8CharacterText,
       textColor: Colors.grey
       );
   }

   Widget contactNumber(){
     return mobileTextFormFieldWithBorder(
       controller: _controller.contactNoController,
       label: mobileNumberText,
       validator: (value){
         if(value == null || value.isEmpty){
           return pleaseEnterYourMobileNumberText;
         }
         else if(value.length != 10){
           return enterCorrectMobileNumberText;
         }
         else
           return null;
       }
     );
   }

   Widget alternateNumber(){
     return mobileTextFormFieldWithBorder(
         controller: _controller.alternateNoController,
         label: alternateNumberText,
         validator: (value) {
           if (value.isNotEmpty) {
             if (value.length != 10) {
               return enterCorrectMobileNumberText;
             }
             else
               return null;
           }
         }
     );
   }

   Widget emailTextField(){
     return emailTextFormFieldWithBorder(
         controller: _controller.emailController,
         label: eMailText,
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

   Widget passwordWidget() {
     return normalTextFormFieldWithBorder(
       controller: _controller.passwordController,
       label: passwordText,
       obscureText: true,
       validator: (value) {
         if (value == null || value.isEmpty) {
           return pleaseEnterYourPasswordText;
         }
         return null; // Return null if the input is valid
       },
     );
   }

   Widget userTypeDropdown(){
     return Obx(() => customDropDown(
       list: _controller.userTypeDropdownItems,
       val: _controller.userTypeValue.value,
       title: "User Type",
       onChanged: (value){
         _controller.userTypeValue.value = value!;
         _controller.update();
       },
     ),
     );
   }

   Widget signupButtonWidget() {
     return customRaisedButton(
       onPressed: () {
         if (formKey.currentState!.validate() ) {
           _controller.signupApi();
         }
       },
       text: signupText,
       radius: 80.0,
       textColor: blackTextColor,
       height: Get.height * 0.07,);
   }

     Widget signinTextWidget(){
       return RichText(
         text: TextSpan(
           children: [
             const TextSpan(
               text: alreadyHaveAccountText,
               style: TextStyle(color: Colors.black),
             ),
             TextSpan(
               text: signInText,
               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
               recognizer: TapGestureRecognizer()
                 ..onTap = () {
                   // Handle the tap event
                   Get.offAllNamed(RouteManagement.loginScreen);
                 },
             ),
           ],
         ),
       );
     }
}
