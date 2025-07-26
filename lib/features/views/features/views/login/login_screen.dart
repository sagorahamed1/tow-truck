import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/utils/app_constant.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import '../../../../../controller/auth_controller.dart';
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
  AuthController authController = Get.find<AuthController>();


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
              Obx(() =>
                 CustomButtonTwo(
                  loading: authController.logInLoading.value,
                    onpress: () async{
                     await requestLocationPermission();

                      if (_globalKey.currentState!.validate()) {
                        authController.handleLogIn(_emailController.text, _passwordController.text);
                      }

                     // if(role == "user"){
                     //   Get.toNamed(AppRoutes.userBottomNavBar);
                     // }else{
                     //   Get.toNamed(AppRoutes.customNavBarScreen);
                     // }

                    },
                    title: 'Login'),
              ),
              SizedBox(height: 20.h),
              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: AppColors.darkColor, fontSize: 14.sp),
                      text: "Don't have an account?",
                      children: [
                    TextSpan(
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                        ),
                        text: '  Register',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(AppRoutes.registerScreen);
                          })
                  ])),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print("✅ Location permission granted");
      // Get.toNamed(AppRoutes.customNavBarScreen);
    } else if (status.isDenied) {
      print("❌ Location permission denied");
    } else if (status.isPermanentlyDenied) {

    }
  }
}
