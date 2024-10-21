import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';
import 'package:onboard/utils/multi_select_dropdown.dart';
import 'package:onboard/view/recruiterData/controller/recruiter_data_controller.dart';

class RecruiterDataScreen extends StatelessWidget {
  RecruiterDataScreen({super.key});

  final RecruiterDataController _controller = Get.put(RecruiterDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: const Text(addRecruiterText),
       centerTitle: true,
     ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                smallSpace(),
                candidateName(),
                smallSpace(),
                contactNumber(),
                smallSpace(),
                alternateNumber(),
                smallSpace(),
                emailTextField(),
                smallSpace(),
                stateDropdown(),
                smallSpace(),
                Obx(() => _controller.locationValue.value == '' ? Container() : locationDropdown()),
                Obx(() => _controller.locationValue.value == '' ? Container() : smallSpace()),
                designationDropdown(),
                smallSpace(),
                qualificationDropdown(),
                // smallSpace(),
                // skilledTextField(),
                smallSpace(),
                yearsOfExperienceTextField(),
                smallSpace(),
                salaryTypeDropdown(),
                smallSpace(),
                salaryTextField(),
                smallSpace(),
                salaryDropdown(),
                smallSpace(),
                skillsDropdown(),
                uploadFileWidget(),
                smallSpace()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget candidateName(){
    return normalTextFormFieldWithBorder(
      controller: _controller.candidateNameController,
      label: candidateNameText,
      inputFormatter: [
        CustomInputFormatter(),
      ],
    );
  }

  Widget contactNumber(){
    return mobileTextFormFieldWithBorder(
      controller: _controller.contactNoController,
      label: contactNoText,
    );
  }

  Widget alternateNumber(){
    return mobileTextFormFieldWithBorder(
      controller: _controller.alternateNoController,
      label: alternateNoText,
    );
  }

  Widget emailTextField(){
    return emailTextFormFieldWithBorder(
      controller: _controller.emailController,
      label: eMailText
    );
  }

  Widget stateDropdown(){
    return Obx(() => customDropDown(
        list: _controller.stateDropdownItems,
        val: _controller.stateValue.value,
        title: stateText,
        onChanged: (value){
          _controller.stateValue.value = value!;
          _controller.updateSelectedState(value);
          _controller.update();
        },
      ),
    );
  }

  Widget locationDropdown(){
    return Obx(() => customDropDown(
      list: _controller.locationDropdownItems,
      val: _controller.locationValue.value,
      title: locationText,
      onChanged: (value){
        _controller.locationValue.value = value!;
        _controller.update();
      },
    ),
    );
  }

  Widget designationDropdown(){
    return Obx(() => customDropDown(
      list: _controller.designationDropdownItems,
      val: _controller.designationValue.value,
      title: designationText,
      onChanged: (value){
        _controller.designationValue.value = value!;
        _controller.update();
      },
    ),
    );
  }

  Widget qualificationDropdown(){
    return Obx(() => customDropDown(
      list: _controller.qualificationDropdownItems,
      val: _controller.qualificationValue.value,
      title: qualificationText,
      onChanged: (value){
        _controller.qualificationValue.value = value!;
        _controller.update();
      },
    ),
    );
  }

  Widget skilledTextField(){
    return normalTextFormFieldWithBorder(
      controller: _controller.skillController,
      label: skillText,
      readOnly: true
    );
  }

  Widget yearsOfExperienceTextField(){
    return numericTextFormFieldWithBorder(
      controller: _controller.experienceController,
      label: yearsOfExperienceText,
      inputFormatter: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}'))
      ],
    );
  }

  Widget salaryTypeDropdown(){
    return Obx(() => customDropDown(
      list: _controller.salaryTypeDropdownItems,
      val: _controller.salaryTypeValue.value,
      title: salaryTypeText,
      onChanged: (value){
        _controller.designationValue.value = value!;
        _controller.update();
      },
    ),
    );
  }

  Widget salaryTextField(){
    return numericTextFormFieldWithBorder(
      controller: _controller.salaryController,
      label: 'Salary (INR)',
      // inputFormatter: [
      //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}$'))
      // ],
    );
  }

  Widget salaryDropdown(){
    return Obx(() => customDropDown(
      list: _controller.salaryRangeDropdownItems,
      val: _controller.salaryRangeValue.value,
      title: salaryRangeText,
      onChanged: (value){
        _controller.salaryRangeValue.value = value!;
        _controller.update();
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
            children: _controller.selectedSkills
                .map((skill) => Chip(
              label: Text(skill),
              onDeleted: () {
                _controller.selectedSkills.remove(skill);
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

  Widget uploadFileWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          final file = _controller.selectedFile.value;
          return file == null
              ? Container()
              : Text(file.name,style: const TextStyle(color: Colors.blue),);
        }),
        const SizedBox(height: 20),
        customRaisedButton(
          text: 'Pick File',
          onPressed: () => _controller.pickFile()
        ),
      ],
    );
  }

}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    final trimmedText = newValue.text.trimLeft();

    final formattedText = trimmedText.replaceAll(RegExp(r'\s{2,}'), ' ');

    final finalText = formattedText.replaceAll(RegExp(r'^\s+'), '');

    return newValue.copyWith(
      text: finalText,
      selection: newValue.selection,
    );
  }
}
