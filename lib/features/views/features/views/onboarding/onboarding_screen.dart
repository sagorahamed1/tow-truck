import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/widgets.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      body: CustomContainer(
        linearColors: [
          Color(0xffA2D0C6),
          Color(0xffA2D0C6),
          Color(0xff768A86),
          Color(0xff768A86),
          Color(0xff768A86),
          Color(0xff768A86),
        ],
        child: Column(
          children: [
            SizedBox(height: 44.h),
            Assets.images.onboardingSecondIcon.image(),
            CustomText(
              top: 34.h,
              bottom: 18.h,
              text: 'WELCOME TO ROAM',fontSize: 28.sp,color: AppColors.darkGoldShade200),
            CustomText(
              left: 44.w,
              right: 44.w,
              text: 'Seamless, affordable, and reliable towing services at your fingertips.',color: AppColors.whiteColor,),

            Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                onPressed: (){
                  Get.offAllNamed(AppRoutes.loginScreen);
                },label: 'Login'),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                backgroundColor: Colors.transparent,
                showlinearColor: false,
                onPressed: (){
                  Get.offAllNamed(AppRoutes.registerScreen);

                },label: 'Register'),
            ),
            SizedBox(height: 90.h)
          ],
        ),
      ),
    );
  }

}
