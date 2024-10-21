import 'package:get/get.dart';
class CandidateController extends GetxController {

  RxString searchText = ''.obs;

  List<String> qualificationDropdownItems = <String>['Option 1', 'Option 2','Option3'];
  RxString qualificationValue = 'Option 1'.obs;
  List<String> positionDropdownItems = <String>['Option 1', 'Option 2','Option3'];
  RxString positionValue = 'Option 1'.obs;
  List<String> experienceDropdownItems = <String>['Option 1', 'Option 2','Option3'];
  RxString experienceValue = 'Option 1'.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
