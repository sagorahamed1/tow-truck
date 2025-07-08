import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import '../../../../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                title: 'Login',
                subtitle: 'Welcome Back! Please enter your details.',
              ),
        
              SizedBox(height: 20.h),
              CustomTextField(
                isEmail: true,
                controller: _emailController,
                hintText: 'Email',
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                isPassword: true,
                controller: _passwordController,
                hintText: 'Password',
              ),
        
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.forgotPasswordScreen),
                  child: CustomText(
                    text: 'Forgot Password?',
                    color: AppColors.errorColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.errorColor,
                  ),
                ),
              ),
        
              SizedBox(height: 24.h),
              CustomButton(onPressed: () {
                if(!_globalKey.currentState!.validate()) return;
              }, label: 'Login'),

              SizedBox(height: 20.h),
              RichText(text: TextSpan(
                  style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 14.sp
                  ),
                  text: "Don't have an account?",
                  children: [
                    TextSpan(
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                        ),
                        text: '  Register',
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Get.toNamed(AppRoutes.registerScreen);

                        }
                    )
                  ]
              )),
              SizedBox(height: 24.h),

            ],
          ),
        ),
      ),
    );
  }
}
