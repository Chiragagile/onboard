import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/assets.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/searchScreen/controller/search_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateSearchScreen extends StatelessWidget {

  final CandidateController controller = Get.put(CandidateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: textWidget(text: 'Search Candidates'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
               //  controller.setSearchText(value); // Trigger filtering
              },
              style: const TextStyle(color: blackTextColor),
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            smallSpace(),

            // List of Candidates
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteManagement.candidateDetailScreen);
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 25,
                            backgroundImage:
                            AssetImage(Assets.person_placeholder)),
                        title: textWidget(text: 'Name : John'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(text: 'Position : Flutter developer'),
                            textWidget(text: 'Experience : 3 yrs'),
                            textWidget(text: 'Email : john@gmail.com'),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Contact : ',
                                style: TextStyle(color: Colors.black,fontSize: 16.0),  // Default color for the text
                              ),
                              TextSpan(
                                text: '9876543210',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final Uri launchUri = Uri(
                                      scheme: 'tel',
                                      path: "9876543210",
                                    );
                                    await launchUrl(launchUri);
                                    // const phoneNumber = 'tel:9876543210';
                                    // if (await canLaunch(phoneNumber)) {
                                    //   await launch(phoneNumber);
                                    // } else {
                                    //   throw 'Could not launch $phoneNumber';
                                    // }
                                  },
                              ),
                            ],
                          ),
                        )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: textWidget(text : 'Filter Candidates',fontWeight: FontWeight.w600,fontSize: 20.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              positionDropdown(),
              smallSpace(),
              experienceDropdown(),
              smallSpace(),
              qualificationDropdown(),
              smallSpace(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Apply Filters'),
            ),
          ],
        );
      },
    );
  }

  Widget qualificationDropdown(){
    return Obx(() => customDropDown(
      list: controller.qualificationDropdownItems,
      val: controller.qualificationValue.value,
      title: qualificationText,
      onChanged: (value){
        controller.qualificationValue.value = value!;
        controller.update();
      },
    ),
    );
  }

  Widget positionDropdown(){
    return Obx(() => customDropDown(
      list: controller.positionDropdownItems,
      val: controller.positionValue.value,
      title: "Position",
      onChanged: (value){
        controller.positionValue.value = value!;
        controller.update();
      },
    ),
    );
  }

  Widget experienceDropdown(){
    return Obx(() => customDropDown(
      list: controller.experienceDropdownItems,
      val: controller.experienceValue.value,
      title: "Years of Experience",
      onChanged: (value){
        controller.experienceValue.value = value!;
        controller.update();
      },
    ),
    );
  }

}
