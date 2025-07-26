import 'package:flutter/material.dart';
import 'package:towservice/features/views/features/views/driver/trip/trip_history/trip_history_screen.dart';
import '../features/views/features/views/document_screen/document_screen.dart';
import '../features/views/features/views/document_screen/national_id_screen.dart';
import '../features/views/features/views/driver/driver_bottom_nav_bar/driver_bottom_nav_bar.dart';
import '../features/views/features/views/driver/driver_home/driver_home_screen.dart';
import '../features/views/features/views/driver/trip/trip_details_screen.dart';
import '../features/views/features/views/driver/wallet/wallet_history_screen.dart';
import '../features/views/features/views/fill_profile/fill_profile_screen.dart';
import '../features/views/features/views/message/chat_screen.dart';
import '../features/views/features/views/message/report_screen.dart';
import '../features/views/features/views/message/report_submit_screen.dart';
import '../features/views/features/views/notification/notification_screen.dart';
import '../features/views/features/views/profile/edit_profile_screen.dart';
import '../features/views/features/views/profile/privacy_policy_all_screen.dart';
import '../features/views/features/views/profile/setting_screen.dart';
import '../features/views/features/views/profile/support_screen.dart';
import '../features/views/features/views/screens.dart';
import '../features/views/features/views/user/user_bottom_nav_bar/user_bottom_nav_bar.dart';
import '../features/views/features/views/user/user_home/job_details_screen.dart';
import '../features/views/features/views/user/user_home/job_post_screen.dart';
import '../features/views/features/views/user/user_home/user_map_screen.dart';

class AppRoutes{
  static const String splashScreen = "/splashScreen";
  static const String roleScreen = "/roleScreen";
  static const String getStartedScreen = "/getStartedScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String registerScreen = "/registerScreen";
  static const String loginScreen = "/loginScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String otpScreen = "/otpScreen";
  static const String resetPasswordScreen = "/resetPasswordScreen";
  static const String driverHomeScreen = "/DriverHomeScreen";
  static const String customNavBarScreen = "/CustomNavBarScreen";
  static const String chatScreen = "/ChatScreen";
  static const String reportScreen = "/ReportScreen";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String supportScreen = "/SupportScreen";
  static const String settingScreen = "/SettingScreen";
  static const String privacyPolicyAllScreen = "/PrivacyPolicyAllScreen";
  static const String reportSubmitScreen = "/ReportSubmitScreen";
  static const String walletHistoryScreen = "/WalletHistoryScreen";
  static const String tripDetailsScreen = "/TripDetailsScreen";
  static const String userBottomNavBar = "/UserBottomNavBar";
  static const String jobPostScreen = "/JobPostScreen";
  static const String userMapScreen = "/UserMapScreen";
  static const String jobDetailsScreen = "/JobDetailsScreen";
  static const String documentScreen = "/DocumentScreen";
  static const String nationalIDScreen = "/NationalIDScreen";
  static const String notificationScreen = "/NotificationScreen";
  static const String tripHistoryScreen = "/TripHistoryScreen";
  static const String fillProfileScreen = "/FillProfileScreen";





  static final routes = <String, WidgetBuilder>{
    splashScreen: (context) => SplashScreen(),
    roleScreen: (context) => RoleScreen(),
    getStartedScreen: (context) => GetStartedScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    loginScreen: (context) => LoginScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    otpScreen: (context) => OtpScreen(),
    resetPasswordScreen: (context) => ResetPasswordScreen(),
    registerScreen : (context) => RegisterScreen(),
    driverHomeScreen : (context) => DriverHomeScreen(),
    customNavBarScreen : (context) => CustomNavBarScreen(),
    chatScreen : (context) => ChatScreen(),
    reportScreen : (context) => ReportScreen(),
    editProfileScreen : (context) => EditProfileScreen(),
    supportScreen : (context) => SupportScreen(),
    settingScreen : (context) => SettingScreen(),
    privacyPolicyAllScreen : (context) => PrivacyPolicyAllScreen(),
    reportSubmitScreen : (context) => ReportSubmitScreen(),
    walletHistoryScreen : (context) => WalletHistoryScreen(),
    tripDetailsScreen : (context) => TripDetailsScreen(),
    userBottomNavBar : (context) => UserBottomNavBar(),
    jobPostScreen : (context) => JobPostScreen(),
    userMapScreen : (context) => UserMapScreen(),
    jobDetailsScreen : (context) => JobDetailsScreen(),
    documentScreen : (context) => DocumentScreen(),
    nationalIDScreen : (context) => NationalIDScreen(),
    notificationScreen : (context) => NotificationScreen(),
    tripHistoryScreen : (context) => TripHistoryScreen(),
    fillProfileScreen : (context) => FillProfileScreen(),

  };



}