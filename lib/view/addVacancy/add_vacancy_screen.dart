import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/utils/multi_select_dropdown.dart';
import 'package:onboard/view/addVacancy/controller/add_vacancy_controller.dart';

class AddVacancyScreen extends StatelessWidget {
  final AddVacancyController controller = Get.put(AddVacancyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vacancy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vacancyDate(),
            smallSpace(),
            noOfVacancy(),
            smallSpace(),
            designationDropdown(),
            smallSpace(),
            skillsDropdown(),
            smallSpace(),
            remarksTextfield(),
            smallSpace(),
            submitButton(),
            smallSpace()
          ],
        ),
      ),
    );
  }

  Widget vacancyDate(){
    return normalTextFormFieldWithBorder(
        controller: TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)),
      label: "Date",
      readOnly: true
    );
  }

  Widget noOfVacancy(){
    return normalTextFormFieldWithBorder(
      controller: controller.vacanciesController,
      label: "No of vacancy",
      maxLength: 3,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly
      ]
    );
  }

  Widget designationDropdown(){
    return Obx(() => customDropDown(
      list: controller.designationDropdownItems,
      val: controller.designationValue.value,
      title: designationText,
      onChanged: (value){
        controller.designationValue.value = value!;
        controller.update();
      },
    ),
    );
  }

  Widget skillsDropdown(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Button to open the multi-select dialog
        customRaisedButton(
          onPressed: () => _showMultiSelectDialog(Get.context!),
          text:"Select Skills",
        ),
        // Display selected skills as chips
        Obx(() {
          return Wrap(
            spacing: 5.0,
            children: controller.selectedSkills
                .map((skill) => Chip(
              label: Text(skill),
              onDeleted: () {
                controller.selectedSkills.remove(skill);
              },
            ))
                .toList(),
          );
        }),
      ],
    );
  }

  void _showMultiSelectDialog(BuildContext context) {
    Get.dialog(
      MultiSelectDialog(),
      barrierDismissible: false,
    );
  }

  Widget remarksTextfield(){
    return normalTextFormFieldWithBorder(
        controller: controller.remarksController,
        label: "Remarks",
    );
  }

  Widget submitButton() {
    return customRaisedButton(text: 'Submit');
  }

}
