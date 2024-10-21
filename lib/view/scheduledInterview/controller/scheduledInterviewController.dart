import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ScheduledInterviewController extends GetxController{

  TextEditingController interviewerNameController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  RxDouble interviewRating = 0.0.obs;
  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = Rx<TimeOfDay?>(null);
  var interviewerName = ''.obs;

  late AgoraClient client;
  RxBool loading = true.obs;
  String token = '';
  String channelName = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
 //   initializeAgora();
    channelName = Get.arguments[0];
    requestPermissions();
    getToken();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }

  Future<void> initializeAgora() async {
    try {
      await client.initialize();
    } catch (e) {
      print("Agora Initialization Error: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getToken() async {

     String url = 'https://dab1ddc8-3406-44a9-a60f-fb9b94b4d080-00-15bv6l4xqq5g5.pike.replit.dev/rtc/$channelName/publisher/uid/1';

     http.Response _response = await http.get(Uri.parse(url));

     Map data = jsonDecode(_response.body);
     token = data['rtcToken'];
     client = AgoraClient(agoraConnectionData: AgoraConnectionData(
        appId: "bcc85cfe4e9f41cb89e6f258212cd19b",
     // tempToken: "006bcc85cfe4e9f41cb89e6f258212cd19bIAAQhOCroIzr2pOCBPlVh2yBLLD7gH2AbssNGhVVQtHVTQx+f9i379yDIgCBjg/ILkoSZwQAAQC+BhFnAgC+BhFnAwC+BhFnBAC+BhFn",
        tempToken: token,
        channelName: channelName,
    ),
        enabledPermission:[Permission.camera, Permission.microphone],
    );
    await client.initialize();

    Future.delayed(const Duration(seconds: 1)).then((value){
      loading.value = false;
      update();
    });
  }

  List<String> cancelDropdownItems = <String>['Candidate Unavailable', 'Rescheduled by Candidate','Rescheduled by Interviewer','Changed Job Requirements'];
  RxString cancelValue = 'Candidate Unavailable'.obs;


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