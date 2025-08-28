import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/widgets.dart';


class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      body: CustomContainer(
        linearColors: [
          Color(0xffABD7B3),
          Color(0xffABD7B3),
          Color(0xff6C8A78),
          Color(0xff6C8A78),
          Color(0xff6C8A78),
          Color(0xff6C8A78),
        ],
        child: Column(
          children: [
            SizedBox(height: 44.h),
            Assets.images.onboardingFirstIcon.image(),
            CustomText(
              top: 34.h,
              bottom: 18.h,
              text: 'Welcome to ...',fontSize: 28.sp,color: AppColors.whiteColor,),
            CustomText(
              left: 44.w,
              right: 44.w,
              text: 'Fast, Affordable, & Reliable Towing—Whenever You Need It!',color: AppColors.whiteColor,),

            Spacer(),
            CustomButton(
              width: 200.w,
              onPressed: (){
                Get.toNamed(AppRoutes.onboardingScreen);
              },label: 'Get Started',),
            SizedBox(height: 90.h)
          ],
        ),
      ),
    );
  }

}
