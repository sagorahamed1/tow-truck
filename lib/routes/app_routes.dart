

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppRoutes{
  static const String splashScreen = "/SplashScreen.dart";
  static const String onBoardScreen = "/onBoardScreen.dart";
  static const String signUpScreen = "/signUpScreen.dart";
  static const String signInScreen = "/signInScreen.dart";
  static const String forgotPassScreen = "/forgotPassScreen.dart";
  static const String verifyScreen = "/verifyScreen.dart";
  static const String resetPassScreen = "/resetPassScreen.dart";
  static const String roleScreen = "/roleScreen.dart";
  static const String profileSetupScreen = "/profileSetupScreen.dart";
  static const String profileSetupDocScreen = "/profileSetupDocScreen.dart";
  static const String allBottomBarScreen = "/allBottomBarScreen.dart";
  static const String earningScreen = "/earningScreen.dart";
  static const String earningDetailsScreen = "/earningDetailsScreen.dart";
  static const String contactUssScreen = "/contactUssScreen.dart";
  static const String bookingDetailsScreen = "/bookingDetailsScreen.dart";
  static const String completedWorkScreen = "/completedWorkScreen.dart";
  static const String jobDetailsScreen = "/jobDetailsScreen.dart";
  static const String notificationScreen = "/notificationScreen.dart";
  static const String profileScreen = "/profileScreen.dart";
  static const String profileInfoEditScreen = "/profileInfoEditScreen.dart";
  static const String settingScreen = "/settingScreen.dart";
  static const String aboutScreen = "/aboutScreen.dart";
  static const String termAndConScreen = "/termAndConScreen.dart";
  static const String privacyScreen = "/privacyScreen.dart";
  static const String changePassScreen = "/changePassScreen.dart";

  static List<GetPage> get routes => [
  // GetPage(name: splashScreen, page: () =>  SplashScreen()),
  // GetPage(name: onBoardScreen, page: () =>  OnboardingScreen()),
  // GetPage(name: signUpScreen, page: () =>  SignUpScreen()),
  // GetPage(name: signInScreen, page: () =>  SignInScreen()),
  // GetPage(name: forgotPassScreen, page: () =>  ForgotPasswordScreen()),
  // GetPage(name: verifyScreen, page: () =>  VerifyScreen()),
  // GetPage(name: resetPassScreen, page: () =>  ResetPassScreen()),
  // GetPage(name: roleScreen, page: () =>  RoleScreen()),
  //GetPage(name: notificationScreen, page: () =>  NotificationsScreen()),
  // GetPage(name: profileScreen, page: () =>  ProfileScreen()),
  // GetPage(name: profileInfoEditScreen, page: () =>  PersonalInfoScreen()),
  //   GetPage(name: settingScreen, page: () =>  SettingsScreen()),
  //   GetPage(name: aboutScreen, page: () =>  AboutScreen()),
  //   GetPage(name: termAndConScreen, page: () =>  TermAndCondition()),
  //   GetPage(name: privacyScreen, page: () =>  PrivacyScreen()),
  //   GetPage(name: changePassScreen, page: () =>  ChangePasswordScreen()),
  //
  ];








// static final GoRouter goRouter = GoRouter(
//     initialLocation: splashScreen,
//     routes: [
//       ///===================Splash Screen=================>>>
//       GoRoute(
//         path: splashScreen,
//         name: splashScreen,
//         builder: (context, state) =>const SplashScreen(),
//         redirect: (context, state) {
//           Future.delayed(const Duration(seconds: 3), ()async{
//             // String role = await PrefsHelper.getString(AppConstants.role);
//             String token = await PrefsHelper.getString(AppConstants.bearerToken);
//
//             if(token.isNotEmpty){
//               // if(role == "user"){
//                 AppRoutes.goRouter.replaceNamed(AppRoutes.signInScreen);
//               // }else{
//               //   AppRoutes.goRouter.replaceNamed(AppRoutes.managerHomeScreen);
//               // }
//             }else{
//               AppRoutes.goRouter.replaceNamed(AppRoutes.onBoardScreen);
//             }
//
//
//           });
//           return null;
//         },
//       ),
//
// ///=========On Boarding Screen========>>
//     GoRoute(
//       path: onBoardScreen,
//       name: onBoardScreen,
//       pageBuilder: (context, state) =>
//        MaterialPage(child: OnboardingScreen()) ,
//   //builder: (context, state) =>  OnboardingScreen(),
//   ),
//
//   ///=========sign Up Screen========>>
//
//   GoRoute(
//   path: signUpScreen,
//   name: signUpScreen,
//   // pageBuilder: (context, state)=>
//   //     MaterialPage(child: SignUpScreen()) ,
//   //builder: (context, state) =>  OnboardingScreen(),
//
//   ),
//     ]
// );
//
//
//   static Page<dynamic> _customTransitionPage(Widget child, GoRouterState state) {
//     return CustomTransitionPage(
//       key: state.pageKey,
//       child: child,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;
//
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         var offsetAnimation = animation.drive(tween);
//
//         return SlideTransition(position: offsetAnimation, child: child);
//       },
//     );
//   }
//
 }