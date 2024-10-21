import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/assets.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduledInterviewListScreen extends StatelessWidget {

   const ScheduledInterviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: textWidget(text: 'Interview Scheduled'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                // controller.setSearchText(value); // Trigger filtering
              },
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            smallSpace(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteManagement.homePage);
                //   Get.toNamed(RouteManagement.callScreen,arguments: '1');
               //       Get.toNamed(RouteManagement.scheduledInterviewDetailScreen);
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
                            ),
                            textWidget(text: 'Date : today 15:30'),
                            RichText(
                              text: const TextSpan(
                                children: [
                                   TextSpan(
                                    text: 'Status : ',
                                    style: TextStyle(color: Colors.black,fontSize: 16.0),  // Default color for the text
                                  ),
                                  TextSpan(
                                    text: 'Pending',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
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
}
