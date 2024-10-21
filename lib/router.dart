import 'package:get/get.dart';
import 'package:onboard/view/addVacancy/add_vacancy_screen.dart';
import 'package:onboard/view/auth/forgotpassword/forgot_screen.dart';
import 'package:onboard/view/auth/login/login_screen.dart';
import 'package:onboard/view/auth/signup/signup_screen.dart';
import 'package:onboard/view/candidateDetail/candidateDetailScreen.dart';
import 'package:onboard/view/dashboard/dashboard_screen.dart';
import 'package:onboard/view/meeting/home_page.dart';
import 'package:onboard/view/meeting/join_with_code.dart';
import 'package:onboard/view/meeting/new_meeting.dart';
import 'package:onboard/view/recruiterData/recuiter_data_screen.dart';
import 'package:onboard/view/scheduledInterview/call.dart';
import 'package:onboard/view/scheduledInterview/scheduledInterviewDetailScreen.dart';
import 'package:onboard/view/scheduledInterview/scheduledInterviewListScreen.dart';
import 'package:onboard/view/scheduledInterview/video_call.dart';
import 'package:onboard/view/searchScreen/search_screen.dart';
import 'package:onboard/view/splash/splash_screen.dart';


class RouteManagement {
  static String splashScreen = "/SplashScreen";
  static String loginScreen = "/LoginScreen";
  static String signupScreen = "/SignupScreen";
  static String forgotScreen = "/ForgotScreen";
  static String dashboardScreen = "/DashboardScreen";
  static String recruiterDataScreen = "/RecruiterDataScreen";
  static String searchScreen = "/CandidateSearchScreen";
  static String candidateDetailScreen = "/CandidateDetailScreen";
  static String scheduledInterviewListScreen = "/ScheduledInterviewListScreen";
  static String scheduledInterviewDetailScreen = "/ScheduledInterviewDetailScreen";
  static String addVacancyScreen = "/AddVacancyScreen";
 // static String callScreen = "/MyCall";
  static String videoCall = "/VideoCall";
  static String homePage = "/HomePage";
  static String newMeeting = "/NewMeeting";
  static String joinWithCode = "/JoinWithCode";

  static final route = [
    //SplashScreen
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: signupScreen,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: forgotScreen,
      page: () => ForgotScreen(),
    ),
    GetPage(
      name: dashboardScreen,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: recruiterDataScreen,
      page: () => RecruiterDataScreen(),
    ),
    GetPage(
      name: searchScreen,
      page: () => CandidateSearchScreen(),
    ),
    GetPage(
      name: candidateDetailScreen,
      page: () => CandidateDetailScreen(),
    ),
    GetPage(
      name: scheduledInterviewListScreen,
      page: () => ScheduledInterviewListScreen(),
    ),
    GetPage(
      name: scheduledInterviewDetailScreen,
      page: () => ScheduledInterviewDetailScreen(),
    ),
    GetPage(
      name: addVacancyScreen,
      page: () => AddVacancyScreen(),
    ),
    // GetPage(
    //   name: callScreen,
    //   page: () => MyCall(callID: Get.arguments[0]),
    // ),
    GetPage(
      name: videoCall,
      page: () => VideoCall(channelName: Get.arguments[0],),
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
    ),
    GetPage(
      name: newMeeting,
      page: () => NewMeeting(),
    ),
    GetPage(
      name: joinWithCode,
      page: () => JoinWithCode(),
    ),
  ];
}