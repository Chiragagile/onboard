import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/view/scheduledInterview/controller/scheduledInterviewController.dart';

class VideoCall extends StatelessWidget {

   String channelName = '';

  final ScheduledInterviewController controller = Get.put(ScheduledInterviewController());

  VideoCall({super.key, required this.channelName});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
    //    final shouldPop = await _showExitConfirmation(context);
        return  false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(() => controller.loading.value
              ? const Center(child: CircularProgressIndicator())
              : Stack(
            children: [
              AgoraVideoViewer(
                client: controller.client,
                layoutType: Layout.floating,
                enableHostControls: true,
              ),
              AgoraVideoButtons(client: controller.client),
            ],
          )),
        ),
      ),
    );
  }

  Future<bool?> _showExitConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Leave Call'),
          content: const Text('Are you sure you want to leave the video call?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay in the call
              child: const Text('No'),
            ),
            TextButton(
              onPressed: ()  {
                Get.back();
        },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
