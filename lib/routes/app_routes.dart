import 'package:flutter/material.dart';
import 'package:towservice/features/views/onboarding/get_started_screen.dart';
import 'package:towservice/features/views/onboarding/onboarding_screen.dart';

import '../features/views/screens.dart';

class AppRoutes{
  static const String splashScreen = "/splashScreen";
  static const String roleScreen = "/roleScreen";
  static const String getStartedScreen = "/getStartedScreen";
  static const String onboardingScreen = "/onboardingScreen";





  static final routes = <String, WidgetBuilder>{
    splashScreen: (context) => SplashScreen(),
    roleScreen: (context) => RoleScreen(),
    getStartedScreen: (context) => GetStartedScreen(),
    onboardingScreen: (context) => OnboardingScreen(),

  };



}