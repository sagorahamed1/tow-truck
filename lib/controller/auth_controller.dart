import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../routes/app_routes.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../services/socket_services.dart';
import '../utils/app_constant.dart';

class AuthController extends GetxController {
  ///************************************************************************///
  RxBool isSelected = true.obs;
  RxBool signUpLoading = false.obs;

  ///===============Sing up ================<>
  handleSignUp({required String name, phone, email, password}) async {
    signUpLoading(true);

    var role = await PrefsHelper.getString(AppConstants.role);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "confirmPassword": "$password",
      "role": "$role"
    };

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.otpScreen, arguments: {'screenType': 'register'});
      PrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']["verificationToken"]);
      ToastMessageHelper.showToastMessage(
          "Account create successful.\n \nNow you have a one time code your email");
      signUpLoading(false);
    } else if (response.statusCode == 1) {
      signUpLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      signUpLoading(false);
    }
  }

  ///************************************************************************///

  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;

  verfyEmail(String otpCode, {String screenType = ''}) async {
    verfyLoading(true);
    var body = {"otp": otpCode};

    var response = await ApiClient.postData(
        ApiConstants.verifyEmailEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // await PrefsHelper.setString(AppConstants.bearerToken, response.body['token']);

      if (screenType == 'forgot') {
        Get.toNamed(AppRoutes.resetPasswordScreen);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
      verfyLoading(false);
    } else if (response.statusCode == 1) {
      verfyLoading(false);
      // ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      verfyLoading(false);
    }
  }

  ///************************************************************************///

  RxBool moreInfoLoading = false.obs;

  ///===============Fill profile or update profile================<>
  moreInformationProfile(File? profileImage, File? driverLicenseFront,
      File? driverLicenseback, String address) async {
    moreInfoLoading(true);
    List<MultipartBody> multipartBody = [
      MultipartBody("image", profileImage!),
      MultipartBody("licenceFront", driverLicenseFront!),
      MultipartBody("licenceBack", driverLicenseback!),
    ];
    Map<String, String> body = {
      "address": address,
    };
    debugPrint('======================> $multipartBody  ==> $body');
    var response = await ApiClient.postMultipartData(
      ApiConstants.updateMoreInformationEndPoint,
      body,
      multipartBody: multipartBody,
    );
    debugPrint("=========${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.toNamed(AppRoutes.thankYouScreen, parameters: {'screenType': "moreInformation"});
      moreInfoLoading(false);
    } else if (response.statusCode == 1) {
      moreInfoLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      moreInfoLoading(false);
    }
  }

  ///************************************************************************///
  ///===============Log in================<>
  RxBool logInLoading = false.obs;

  handleLogIn(String email, String password) async {
    logInLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "password": password,
    };
    var response = await ApiClient.postData(
        ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data'];

      PrefsHelper.setString(AppConstants.role, data["user"]['role']);
      PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['tokens']["accessToken"]);
      PrefsHelper.setString(AppConstants.email, email);
      PrefsHelper.setString(AppConstants.name, data["user"]['name']);
      PrefsHelper.setString(AppConstants.userId, data["user"]['_id']);
      PrefsHelper.setBool(AppConstants.isLogged, true);

      var role = data["user"]['role'];
      print("=============role ==============? $role");
      if (role == "provider") {
        print("===================user bottom nav bar");
        Get.offAllNamed(AppRoutes.customNavBarScreen);
      } else if (role == "user") {
        print("===================user bottom nav bar");
        Get.offAllNamed(AppRoutes.userBottomNavBar);
      }
      ToastMessageHelper.showToastMessage('Your are logged in');

      logInLoading(false);
      await PrefsHelper.setString(
          AppConstants.image, data['image']["publicFileURL"]);
      SocketServices socketService = SocketServices();
      socketService.disconnect(isManual: true);
      await socketService.init();
      SocketServices();
    } else if (response.statusCode == 1) {
      logInLoading(false);
      ToastMessageHelper.showToastMessage(
          secound: 22, "${response.body["message"]}");
    } else {
      ///******** When user do not able to verify their account thay have to verify there account then they can go to the app********
      if (response.body["message"] == "Please verify your account") {
        // var userRole = await PrefsHelper.getString(AppConstants.role);
        // if(userRole.toString() == AppString.asEmployee){
        //   ///******** employee do not verify there e-mail go to the otp verify screen********///
        //   isSelected(false);
        //   Get.toNamed(AppRoutes.otpVerfyScreen, parameters: {'email': email});
        // }else{
        //   ///******** if normal user do not verify there e-mail go to the otp verify screen********///
        //   Get.toNamed(AppRoutes.otpVerfyScreen, parameters: {'email': email});
        // }

        ToastMessageHelper.showToastMessage(
            secound: 22,
            "your account create is successful but you don't verify your email. \n \n Please verify your account");
      }

      ///******** if user as a employee go to the otp verify screen or more information screen************///
      else if (response.body["message"] == "Please complete your profile") {
        // ToastMessageHelper.showToastMessage(secound:  22 , "your account create is successful but you don't verify your email. \n \n Please verify your account");
        //  Get.toNamed(AppRoutes.moreInformationScreen);
      } else if (response.body["message"] ==
          "Your account is currently being verified by the admin. Thank you for your patience!") {
        // Get.toNamed(AppRoutes.thankYouScreen, parameters: {'screenType': "moreInformation"});
      } else if (response.body["message"] == "Incorrect password") {
        ToastMessageHelper.showToastMessage(response.body["message"]);
      }
      logInLoading(false);
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }

  ///************************************************************************///

  ///===============Forgot Password================<>
  RxBool forgotLoading = false.obs;

  handleForgot(String email) async {
    forgotLoading(true);
    var body = {"email": email};

    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      Get.toNamed(AppRoutes.otpScreen,arguments: {'screenType' : 'forgot'});
      PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["resetPasswordToken"]);
      forgotLoading(false);
    } else if (response.statusCode == 1) {
      forgotLoading(false);
      // ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      forgotLoading(false);
    }
  }

  ///===============Set Password================<>
  RxBool setPasswordLoading = false.obs;

  setPassword(String password) async {

    setPasswordLoading(true);
    var body = {
      "password": password.toString().trim(),
      "confirmPassword": password.toString().trim()
    };

    var response = await ApiClient.postData(
        ApiConstants.setPasswordEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.loginScreen);
      ToastMessageHelper.showToastMessage('Password Changed');
      print("======>>> successful");
      setPasswordLoading(false);
    } else if (response.statusCode == 1) {
      setPasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      setPasswordLoading(false);
    }
  }

  ///===============Resend================<>
  RxBool resendLoading = false.obs;

  reSendOtp() async {
    resendLoading(true);
    var body = {};

    var response = await ApiClient.postData(
        ApiConstants.resendOtpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setString(
          AppConstants.bearerToken, response.body["data"]["verificationToken"]);
      ToastMessageHelper.showToastMessage(
          'You have got an one time code to your email');
      print("======>>> successful");
      resendLoading(false);
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      resendLoading(false);
    }
  }

  ///===============Change Password================<>
  RxBool changePasswordLoading = false.obs;

  changePassword(String oldPassword, newPassword) async {
    changePasswordLoading(true);
    var body = {"oldPassword": "$oldPassword", "newPassword": "$newPassword"};

    var response =
        await ApiClient.postData(ApiConstants.changePassword, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('Password Changed Successful');
      print("======>>> successful");
      changePasswordLoading(false);
    } else if (response.statusCode == 1) {
      changePasswordLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage(response.body['message']);
      changePasswordLoading(false);
    }
  }

  final RxInt countdown = 60.obs;
  final RxBool isCountingDown = false.obs;

  void startCountdown() {
    isCountingDown.value = true;
    countdown.value = 60;
    update();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
        update();
      } else {
        timer.cancel();
        isCountingDown.value = false;
        update();
      }
    });
  }
}
