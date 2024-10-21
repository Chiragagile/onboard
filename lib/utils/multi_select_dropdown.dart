import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/view/recruiterData/controller/recruiter_data_controller.dart';

class MultiSelectDialog extends StatelessWidget {

  final RecruiterDataController controller = Get.put(RecruiterDataController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Skills"),
      content: SingleChildScrollView(
        child: ListBody(
          children: controller.skills.map((skill) {
            return Obx(() {
              return CheckboxListTile(
                title: Text(skill),
                value: controller.selectedSkills.contains(skill),
                onChanged: (bool? isChecked) {
                  controller.updateSelectedSkills(skill, isChecked ?? false);
                },
              );
            });
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
        TextButton(
          child: Text("Clear"),
          onPressed: () {
            controller.clearSelectedSkills();
          },
        ),
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Get.back(); // Close the dialog after confirmation
          },
        ),
      ],
    );
  }
}
