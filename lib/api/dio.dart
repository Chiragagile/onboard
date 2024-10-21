import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as fromGet;
import 'package:get/get.dart';
import 'package:onboard/api/api.dart';
import 'package:onboard/utils/app_constants.dart';
import 'package:onboard/utils/common_methods.dart';

class GetDio {
  static Dio getDio(bool isShowLoading,{bool fromVideos = false}) {
    // final LoginController _loginController =
    // fromGet.Get.find<LoginController>();
    String token ;
    token = getStorage.read("isLogin") == true
        ? getStorage.read("token")
        : "";
    if (kDebugMode) {
      print("token $token");
    }

    Dio dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          options.connectTimeout = const Duration(seconds: 10000);
          options.receiveTimeout = const Duration(seconds: 10000);
          options.sendTimeout = const Duration(seconds: 10000);
          options.followRedirects = true;
          options.baseUrl = API.baseUrl;
     //     options.contentType = Headers.formUrlEncodedContentType;
     //      if (token.isNotEmpty)
     //        options.headers["authorization"] = token;

          if (isShowLoading) {
            fromGet.Get.dialog(Center(child: CircularProgressIndicator(color: Colors.tealAccent.shade700,)));
          } else {}

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode == 200 || response.statusCode == 201) {
            if(fromVideos != true){
              if(isShowLoading){
                fromGet.Get.back();
              }
            }
          } else if(response.statusCode == 401){
            if (isShowLoading) {
              fromGet.Get.back();
            }
          }
          else {
            print(response.data.toString());
            if (isShowLoading) {
              fromGet.Get.back();
            }
          }
          return handler.next(response);
        },
        onError: (DioException dioError, handler) async {
          if (dioError.type == DioExceptionType.connectionTimeout) {
            fromGet.Get.showSnackbar(snackBarWidget(
                title: errorText,
                message: internetErrorText,
                icon: Icons.error,
                iconColor: Colors.red));
          }
          else if (dioError.type == DioExceptionType.unknown){
            final connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.none) {
              fromGet.Get.showSnackbar(snackBarWidget(
                  title: noInternetText,
                  message: internetErrorText,
                  icon: Icons.error,
                  iconColor: Colors.red));
            }else{
              print(connectivityResult.toString());
            }
          }
          if (isShowLoading) {
            fromGet.Get.back();
          }
          else if(dioError.response!.statusCode == 401){
            if (isShowLoading) {
              fromGet.Get.back();
            }
            // fromGet.Get.offAllNamed(RouteManagement.loginScreen);
          }
          else {
            fromGet.Get.showSnackbar(snackBarWidget(
                title: errorText,
                message: somethingWrongErrorText,
                icon: Icons.error,
                iconColor: Colors.red));
          }
          return handler.next(dioError); //continue
        },
      ),
    );
    return dio;
  }
}