import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/api/api.dart';
import 'package:onboard/api/dio.dart';
import 'package:onboard/model/cityModel.dart';
import 'package:onboard/model/getMasterData.dart';
import 'package:onboard/model/stateModel.dart';
import 'package:onboard/utils/common_methods.dart';

class RecruiterDataController extends GetxController{

  var selectedFile = Rx<PlatformFile?>(null);

  TextEditingController candidateNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController alternateNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController skillController = TextEditingController(text: 'Skilled');
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  List<StateModel> statesList = [];
  List<String> stateDropdownItems = <String>[];
  RxString stateValue = ''.obs;
  RxString stateCode = ''.obs;
  List<CityModel> locationList = [];
  List<String> locationDropdownItems = <String>[];
  RxString locationValue = ''.obs;
  List<Designations> designationList = [];
  List<Qualification> qualificationList = [];
  List<String> designationDropdownItems = <String>[];
  RxString designationValue = ''.obs;
  List<String> qualificationDropdownItems = <String>[];
  RxString qualificationValue = ''.obs;
  List<Salarydtl> salaryDetailList = [];
  List<String> salaryTypeDropdownItems = <String>[];
  RxString salaryTypeValue = ''.obs;
  List<String> salaryRangeDropdownItems = <String>[];
  RxString salaryRangeValue = ''.obs;


  List<String> skills = ["Flutter", "Dart", "Java", "Python", "JavaScript"];

  RxList<String> selectedSkills = <String>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStates();
    getMasterData();
  }

  void updateSelectedSkills(String skill, bool isSelected) {
    if (isSelected) {
      selectedSkills.add(skill);
    } else {
      selectedSkills.remove(skill);
    }
  }

  void clearSelectedSkills() {
    selectedSkills.clear();
  }

   pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      selectedFile.value = result.files.first;
    }
  }

  void updateSelectedState(String selectedName) {
    // Find the state model that matches the selected name
    var selectedState = statesList.firstWhere((state) => state.stateName == selectedName);
    stateCode.value = selectedState.stateCode!;
    update();
    getLocation();
  }


  getStates() {
    print("nkfenfke ${API.getStates}");
    GetDio.getDio(false).get(API.getStates).then((response) {
      print("Response $response");
      if (response.statusCode == 200) {
        statesList.clear();
        List states = response.data['data'];
        for (var state in states) {
          statesList.add(StateModel.fromJson(state)); // Create StateModel from JSON
        }
        stateValue.value = statesList[0].stateName!;
        stateCode.value = statesList[0].stateCode!;
        getLocation();
        stateDropdownItems = statesList.map((state) => state.stateName!).toList();
        update();
      } else {
        Get.showSnackbar(snackBarWidget(
            title: "Error",
            message: response.data["msg"].toString(),
            icon: Icons.error,
            iconColor: Colors.red));
      }
    }).catchError((error) {
      Get.showSnackbar(snackBarWidget(
          title: "Error",
          message: error.toString(),
          icon: Icons.error,
          iconColor: Colors.red));
    });
  }

  getLocation() {
    GetDio.getDio(true).get(API.getCity + stateCode.value).then((response) {
      print("Response $response");

      if (response.statusCode == 200) {
        List city = response.data['data'];

        if (city.isNotEmpty) {
          // Clear previous list and populate with new data
          locationList.clear();

          // Add new cities to the location list
          for (var cityData in city) {
            locationList.add(CityModel.fromJson(cityData));
          }

          // Set the first city as the default selected location
          locationValue.value = locationList[0].cityName!;

          // Populate dropdown items
          locationDropdownItems = locationList.map((city) => city.cityName!).toList();

        } else {
          // Handle empty city list
          locationList.clear(); // Ensure the list is cleared
          locationDropdownItems.clear(); // Clear dropdown items
          locationValue.value = ''; // Clear selected value

          // Show a message indicating no data
          Get.showSnackbar(snackBarWidget(
            title: "No Data",
            message: "No cities available for the selected state.",
            icon: Icons.info,
            iconColor: Colors.blue,
          ));
        }

        update(); // Update the UI

      } else {
        // Handle error response
        Get.showSnackbar(snackBarWidget(
            title: "Error",
            message: response.data["msg"].toString(),
            icon: Icons.error,
            iconColor: Colors.red));
      }
    }).catchError((error) {
      // Handle network or other errors
      Get.showSnackbar(snackBarWidget(
          title: "Error",
          message: error.toString(),
          icon: Icons.error,
          iconColor: Colors.red));
    });
  }

  getMasterData() {
    GetDio.getDio(false).get(API.getMaster).then((response) {
      if (response.statusCode == 200 && response.data['success']) {

        List qualifications = response.data['data']['qualification'];
        List designations = response.data['data']['designations'];
        List salaryDetail = response.data['data']['salarydtl'];

        qualificationDropdownItems.clear();
        designationDropdownItems.clear();
        designationList.clear();
        qualificationList.clear();
        designationValue.value = '';
        qualificationValue.value = '';
        salaryDetailList.clear();
        salaryTypeDropdownItems.clear();
        salaryRangeDropdownItems.clear();
        salaryRangeValue.value = '';
        salaryTypeValue.value = '';

        // Add qualifications to the list using the QualificationModel
        for (var item in qualifications) {
          qualificationList.add(Qualification.fromJson(item));
        }

        // Add designations to the list using the DesignationModel
        for (var item in designations) {
          designationList.add(Designations.fromJson(item));
        }
        for (var item in salaryDetail) {
          salaryDetailList.add(Salarydtl.fromJson(item));
        }

        designationDropdownItems = designationList.map((designation) => designation.designation!).toList();
        designationValue.value = designationDropdownItems[0];
        qualificationDropdownItems = qualificationList.map((qualification) => qualification.qualification!).toList();
        qualificationValue.value = qualificationDropdownItems[0];
        salaryRangeDropdownItems = salaryDetailList.map((salaryDetail) => salaryDetail.salaryRange!).toList();
        salaryRangeValue.value = salaryRangeDropdownItems[0];
        salaryTypeDropdownItems = salaryDetailList.map((salaryDetail) => salaryDetail.salaryType!).toList();
        salaryTypeValue.value = salaryTypeDropdownItems[0];

        // Update the UI after fetching data
        update();

      } else {
        // Handle unsuccessful response
        Get.showSnackbar(snackBarWidget(
            title: "Error",
            message: response.data["msg"] ?? "Failed to fetch data",
            icon: Icons.error,
            iconColor: Colors.red));
      }
    }).catchError((error) {
      // Handle network or other errors
      Get.showSnackbar(snackBarWidget(
          title: "Error",
          message: error.toString(),
          icon: Icons.error,
          iconColor: Colors.red));
    });
  }





}