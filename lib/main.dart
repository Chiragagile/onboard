import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

RxInt steps = 0.obs;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return getMaterialAppWidget();
  }

  Widget getMaterialAppWidget() {
    return GetMaterialApp(
      title: appNameText,
      getPages: RouteManagement.route,
      themeMode: ThemeMode.system,
      darkTheme: AppStyle.darkTheme,
      theme: AppStyle.lightTheme,
      initialRoute: RouteManagement.splashScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}