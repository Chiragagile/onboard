import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

class AddVacancyController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var designation = ''.obs;

  final vacanciesController = TextEditingController();
  final skillsController = TextEditingController();
  final remarksController = TextEditingController();

  List<String> designationDropdownItems = <String>[];
  RxString designationValue = ''.obs;

  List<String> skills = ["Flutter", "Dart", "Java", "Python", "JavaScript"];

  RxList<String> selectedSkills = <String>[].obs;

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void submitForm() {
    // Handle form submission logic here
    print("Vacancies: ${vacanciesController.text}");
    print("Designation: ${designation.value}");
    print("Skills: ${skillsController.text}");
    print("Remarks: ${remarksController.text}");
  }
}
