 import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/controller/auth_controller.dart';
import 'package:towservice/helpers/privacy_and_terms_helper.dart';
import 'package:towservice/helpers/toast_message_helper.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import '../../../../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  AuthController authController = Get.find<AuthController>();
  final PrivacyController privacyController = Get.find<PrivacyController>();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

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
                logoSize: 120.r,
                title: 'Create Account',
                subtitle: 'Fill the information to create a new account.',
              ),
        
              SizedBox(height: 20.h),
              CustomTextField(
                labelText: 'Name',
                controller: _nameController,
                hintText: 'Name',
              ),

              CustomTextField(
                keyboardType: TextInputType.number,
                labelText: 'Phone Number',
                controller: _numberController,
                hintText: 'Number',
              ),


              CustomTextField(
                isEmail: true,
                labelText: 'E-mail',
                controller: _emailController,
                hintText: 'E-mail',
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                labelText: 'Password',
                isPassword: true,
                controller: _passwordController,
                hintText: 'Password',
              ),

              CustomTextField(
                labelText: 'Confirm Password',
                isPassword: true,
                controller: _confirmPassController,
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

              PrivacyAndTermsHelper(),

              SizedBox(height: 10.h),
              Obx(()=>
                 CustomButtonTwo(
                    loading: authController.signUpLoading.value,
                    onpress: () {
                  if(_globalKey.currentState!.validate()){

                    if(privacyController.isChecked.value == true){
                      authController.handleSignUp(
                          name: _nameController.text,
                          phone: _numberController.text,
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                    }else{
                      ToastMessageHelper.showToastMessage("Please accept terms of services and privacy policy");
                    }



                  }





                }, title: 'Register'),
              ),



              SizedBox(height: 20.h),
              RichText(text: TextSpan(
                  style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 14.sp
                  ),
                  text: "Have any account?",
                  children: [
                    TextSpan(
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                          color: AppColors.primaryColor,
                        ),
                        text: '  Login',
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Get.toNamed(AppRoutes.loginScreen);

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
