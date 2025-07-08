import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import '../../../../../widgets/widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              AuthTitleWidgets(
                title: 'Reset Password',
              ),
        
              SizedBox(height: 20.h),
              CustomTextField(
                isPassword: true,
                controller: _passwordController,
                hintText: 'password',
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                isPassword: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
        

              SizedBox(height: 24.h),
              CustomButton(onPressed: () {
                if(!_globalKey.currentState!.validate()) return;
                Get.offAllNamed(AppRoutes.loginScreen);
              }, label: 'Save Password'),

              SizedBox(height: 24.h),

            ],
          ),
        ),
      ),
    );
  }
}
