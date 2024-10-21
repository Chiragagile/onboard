import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/utils/assets.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/view/candidateDetail/controller/candidateScreenDetailController.dart';

class CandidateDetailScreen extends StatelessWidget {

  CandidateDetailScreen({super.key});

  final Candidatescreendetailcontroller controller =
  Get.put(Candidatescreendetailcontroller());

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
                  radius: 60, backgroundImage: AssetImage(Assets.person_placeholder)),
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
            const Spacer(), // Push the button to the bottom
            customRaisedButton(
              text: 'Schedule Interview',
              onPressed: () {
                _showScheduleInterviewBottomSheet(context);
              },
              color: Colors.blue,
            ),
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
          ), // Bold heading
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black, fontSize: 16.0), // Regular text
          ),
        ],
      ),
    );
  }

  void _showScheduleInterviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return scheduleInterviewBottomSheet();
      },
    );
  }

  Widget scheduleInterviewBottomSheet() {
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
                  : 'Date of Interview : ${controller.formattedDate}',
            ),
          )),
          Obx(() => TextButton(
            onPressed: () => _selectTime(Get.context!),
            child: Text(
              controller.formattedTime.isEmpty
                  ? 'Select Time'
                  : 'Time of Interview : ${controller.formattedTime}',
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
    return customRaisedButton(
        text: 'Submit'
    );
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

}
