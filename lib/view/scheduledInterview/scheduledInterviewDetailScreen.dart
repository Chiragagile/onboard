import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:onboard/utils/assets.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/scheduledInterview/controller/scheduledInterviewController.dart';

class ScheduledInterviewDetailScreen extends StatelessWidget {

  ScheduledInterviewDetailScreen({super.key});

  final ScheduledInterviewController controller = Get.put(ScheduledInterviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Candidate Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(Assets.person_placeholder),
              ),
            ),
            smallSpace(),
            textWidgetDetail(heading: "Name : ", text: "John"),
            smallSpace(),
            textWidgetDetail(heading: "Designation : ", text: "Frontend Developer"),
            smallSpace(),
            textWidgetDetail(heading: "Experience : ", text: "3 years"),
            smallSpace(),
            textWidgetDetail(heading: "Contact : ", text: "9876543210"),
            smallSpace(),
            textWidgetDetail(heading: "Email : ", text: "john@gmail.com"),
            smallSpace(),
            textWidgetDetail(heading: "Skills : ", text: "Flutter, Dart, SQL"),
            smallSpace(),
            textWidgetDetail(heading : 'Date : ',text: 'Today 15:30'),
            const Spacer(),
            actionButtonsRow(), // The buttons row
          ],
        ),
      ),
    );
  }

  Widget textWidgetDetail({required String heading, required String text}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: heading,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0),
          ),
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget actionButtonsRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: customRaisedButton(
                text: 'Reschedule',
                onPressed: () {
                  _showScheduleInterviewBottomSheet(Get.context!);
                },
                color: Colors.blue, // Different color for each button
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: customRaisedButton(
                text: 'Update Status',
                onPressed: () {
                  _showUpdateStatusBottomSheet(Get.context!);
                },
                color: Colors.green, // Different color for each button
              ),
            ),
          ],
        ),
        smallSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: customRaisedButton(
                text: 'Next Round',
                onPressed: () {
                  nextRoundInterviewBottomSheet(Get.context!);
                },
                color: Colors.orange, // Different color for each button
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: customRaisedButton(
                text: 'Cancel',
                onPressed: () {
                  _showCancelDialog(Get.context!);
                },
                color: Colors.red, // Different color for each button
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showScheduleInterviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return reScheduleInterviewBottomSheet();
      },
    );
  }

  Widget reScheduleInterviewBottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textWidget(text: 'Re-Schedule Interview'),
          smallSpace(),
          Obx(() => TextButton(
            onPressed: () => _selectDate(Get.context!),
            child: Text(
              controller.formattedDate.isEmpty
                  ? 'Select Date'
                  : 'Date of Interview: ${controller.formattedDate}',
            ),
          )),
          Obx(() => TextButton(
            onPressed: () => _selectTime(Get.context!),
            child: Text(
              controller.formattedTime.isEmpty
                  ? 'Select Time'
                  : 'Time of Interview: ${controller.formattedTime}',
            ),
          )),
          smallSpace(),
          interviewTypeDropdown(),
          smallSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: interviewerName(),
          ),
          smallSpace(),
          applyButton(),
          smallSpace()
        ],
      ),
    );
  }

  nextRoundInterviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textWidget(text: 'Schedule Interview'),
            smallSpace(),
            Obx(() => TextButton(
              onPressed: () => _selectDate(Get.context!),
              child: Text(
                controller.formattedDate.isEmpty
                    ? 'Select Date'
                    : 'Date of Interview: ${controller.formattedDate}',
              ),
            )),
            Obx(() => TextButton(
              onPressed: () => _selectTime(Get.context!),
              child: Text(
                controller.formattedTime.isEmpty
                    ? 'Select Time'
                    : 'Time of Interview: ${controller.formattedTime}',
              ),
            )),
            smallSpace(),
            interviewTypeDropdown(),
            smallSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: interviewerName(),
            ),
            smallSpace(),
            applyButton(),
            smallSpace()
          ],
        ),
      );
  });
  }

  Widget interviewerName() {
    return normalTextFormFieldWithBorder(
      controller: controller.interviewerNameController,
      label: "Interviewer Name",
      inputFormatter: [],
    );
  }

  Widget interviewTypeDropdown() {
    return Obx(
          () => customDropDown(
        list: controller.interviewTypeDropdownItems,
        val: controller.interviewTypeValue.value,
        title: "Interview Type",
        onChanged: (value) {
          controller.interviewTypeValue.value = value!;
          controller.update();
        },
      ),
    );
  }

  Widget applyButton() {
    return customRaisedButton(text: 'Submit');
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.setInterviewDate(pickedDate);
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      controller.setInterviewTime(pickedTime);
    }
  }

  _showCancelDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
       return Padding(
           padding: const EdgeInsets.all(16.0),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             cancelReasonDropdown(),
             smallSpace(),
             customRaisedButton(
               text: 'Submit',
               onPressed: () {
                 Navigator.of(context).pop();
                 Get.showSnackbar(
                   const GetSnackBar(
                     message: 'Interview got cancelled',
                     duration: Duration(seconds: 2),
                   ),
                 );
               },
             ),
           ],
         ),
       );
      },
    );
  }

  _showUpdateStatusBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Update Interview Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              smallSpace(),

              // Rating bar widget
              RatingBar.builder(
                initialRating: controller.interviewRating.value,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  controller.interviewRating.value = rating; // Update the rating in controller
                },
              ),

              smallSpace(),

              // Remark TextField

              normalTextFormFieldWithBorder(label: 'Remarks'),

              // TextField(
              //   controller: controller.remarkController,
              //   decoration: const InputDecoration(
              //     labelText: 'Remarks',
              //     border: OutlineInputBorder(),
              //   ),
              // ),

              smallSpace(),

              // Submit button
              customRaisedButton(
                text: 'Submit',
                onPressed: () {
                  // Handle submission logic
                  Navigator.of(context).pop(); // Close the bottom sheet
                  Get.showSnackbar(
                    const GetSnackBar(
                      message: 'Interview status updated successfully!',
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget cancelReasonDropdown(){
    return Obx(() => customDropDown(
      list: controller.cancelDropdownItems,
      val: controller.cancelValue.value,
      title: '',
      onChanged: (value){
        controller.cancelValue.value = value!;
        controller.update();
      },
    ),
    );
  }

}



