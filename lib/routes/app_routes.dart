import 'package:flutter/material.dart';
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

  };



}