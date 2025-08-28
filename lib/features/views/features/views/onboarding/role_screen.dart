import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/utils/app_constant.dart';
import 'package:towservice/widgets/auth_title_widgets.dart';
import 'package:towservice/widgets/custom_container.dart';
import 'package:towservice/widgets/custom_scaffold.dart';
import 'package:towservice/widgets/custom_text.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // SizedBox(height: 40.h),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: const AuthTitleWidgets(
              title: 'How will you use our Tow Service Platform?',
              subtitle: 'Choose your role to get started',
            ),
          ),





        ],
      ),
      bottomSheet:  CustomContainer(
        topLeftRadius: 40.r,
        topRightRadius: 40.r,
        color: AppColors.whiteShade400,
        height: 450.h,
        elevation: true,
        elevationColor: const Color(0xffD46A6A1A).withOpacity(0.15),
        child: Stack(
          children: [
            /// Background Image Positioned
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Assets.images.onboardingImage.image(),
            ),


            /// Role Selection Options
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIconsWidget(Assets.icons.towService.svg(),'I NEED A TOW SERVICES', (){
                      PrefsHelper.setString(AppConstants.role, "user");
                      Get.toNamed(AppRoutes.getStartedScreen);
                    }),
                    SizedBox(height: 20.h),
                    _buildIconsWidget(Assets.icons.towDriver.svg(),'I AM A TOW DRIVER',(){
                      PrefsHelper.setString(AppConstants.role, "provider");
                      Get.toNamed(AppRoutes.getStartedScreen);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconsWidget(Widget icon,String title, VoidCallback? onTap) {
    return CustomContainer(
      alignment: Alignment.center,
      onTap: onTap,
      radiusAll: 8.r,
      color: Color(0xffFDF8EB),
      elevationColor: const Color(0xff6a6a1a).withOpacity(0.15),
      elevation: true,
      width: 200.w,
      height: 160.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,

          CustomText(
            top: 4.h,
              text: title),
        ],
      ),
    );
  }
}
