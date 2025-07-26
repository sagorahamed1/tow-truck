import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import '../../../../../controller/auth_controller.dart';
import '../../../../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthTitleWidgets(
              title: 'Forget Password',
              subtitle: 'Please enter your phone to reset your password.',
            ),
        
            SizedBox(height: 20.h),
            Form(
              key: _globalKey,
              child: CustomTextField(
                isEmail: true,
                controller: _emailController,
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 24.h),
            Obx(() =>
              CustomButtonTwo(
                  loading: authController.forgotLoading.value,
                  onpress: () {
                if(!_globalKey.currentState!.validate()) return;
                authController.handleForgot(_emailController.text);
              }, title: 'Send OTP'),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
