import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/auth_title_widgets.dart';
import 'package:towservice/widgets/custom_container.dart';
import 'package:towservice/widgets/custom_scaffold.dart';
import 'package:towservice/widgets/custom_text.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      body: Column(
        children: [
          SizedBox(height: 40.h),
          const AuthTitleWidgets(
            title: 'How will you use our Tow Service Platform?',
            subtitle: 'Choose your role to get started',
          ),
        ],
      ),
      bottomSheet: CustomContainer(
        topLeftRadius: 40.r,
        topRightRadius: 40.r,
        color: AppColors.whiteShade400,
        height: 500.h,
        elevation: true,
        elevationColor: const Color(0xffD46A6A1A).withOpacity(0.15),
        child: Stack(
          children: [
            /// Background Image Positioned
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Assets.images.onboardingImage.image(),
            ),

            /// Role Selection Options
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildIconsWidget(Assets.icons.towService.svg(),'I NEED A TOW SERVICES'),
                    SizedBox(height: 20.h),
                    _buildIconsWidget(Assets.icons.towDriver.svg(),'I AM A TOW DRIVER'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconsWidget(Widget icon,String title) {
    return CustomContainer(
      alignment: Alignment.center,
      onTap: (){
        Get.toNamed(AppRoutes.getStartedScreen);
      },
      radiusAll: 8.r,
      color: AppColors.whiteShade500,
      elevationColor: const Color(0xffD46A6A1A).withOpacity(0.15),
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
