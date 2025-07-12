import 'package:flutter/material.dart';
import '../features/views/features/views/driver/driver_bottom_nav_bar/driver_bottom_nav_bar.dart';
import '../features/views/features/views/driver/driver_home/driver_home_screen.dart';
import '../features/views/features/views/message/chat_screen.dart';
import '../features/views/features/views/message/report_screen.dart';
import '../features/views/features/views/profile/edit_profile_screen.dart';
import '../features/views/features/views/profile/privacy_policy_all_screen.dart';
import '../features/views/features/views/profile/setting_screen.dart';
import '../features/views/features/views/profile/support_screen.dart';
import '../features/views/features/views/screens.dart';

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

  };



}