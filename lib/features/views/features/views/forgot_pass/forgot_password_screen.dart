import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import '../../../../../widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


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
            CustomButton(onPressed: () {
              if(!_globalKey.currentState!.validate()) return;
              Get.toNamed(AppRoutes.otpScreen,arguments: {'screenType' : 'forget'});
            }, label: 'Send OTP'),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
