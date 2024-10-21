import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Candidatescreendetailcontroller extends GetxController {
  TextEditingController interviewerNameController = TextEditingController();

  // Scheduler properties
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  var interviewerName = ''.obs;

  List<String> interviewTypeDropdownItems = <String>["Technical", "HR"];
  RxString interviewTypeValue = 'Technical'.obs;

  void setInterviewDate(DateTime date) {
    selectedDate.value = date;
  }

  void setInterviewTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  String get formattedDate => selectedDate.value != null
      ? DateFormat('dd-MM-yyyy').format(selectedDate.value!)
      : '';

  String get formattedTime => selectedTime.value != null
      ? '${selectedTime.value!.hour}:${selectedTime.value!.minute.toString().padLeft(2, '0')}'
      : '';
}
