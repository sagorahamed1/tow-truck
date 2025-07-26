import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import '../../../../../controller/auth_controller.dart';
import '../../../../../widgets/widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();

  final String  screenType = Get.arguments['screenType'];


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthTitleWidgets(
              title: 'OTP',
              subtitle: 'Please enter the OTP code, We’ve sent you in your Phone.',
            ),
        
            SizedBox(height: 20.h),
            Form(
              key: _globalKey,
              child: CustomPinCodeTextField(
                controller: _otpController,
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  authController.reSendOtp();
                },
                child: CustomText(
                  text: 'Resend Code',
                  color: AppColors.errorColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.errorColor,
                ),
              ),
            ),
            SizedBox(height: 44.h),
            Obx(() =>
               CustomButtonTwo(
                  loading: authController.verfyLoading.value,
                  onpress: () {
                if(!_globalKey.currentState!.validate()) return;
                if(screenType == 'register'){
                  authController.verfyEmail(_otpController.text);
                  _otpController.clear();
                }else{
                  authController.verfyEmail(_otpController.text, screenType: "forgot");
                }
              }, title: 'Verify'),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
