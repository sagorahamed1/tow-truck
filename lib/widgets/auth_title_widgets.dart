import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/global/custom_assets/fonts.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_text.dart';



class AuthTitleWidgets extends StatelessWidget {
  const AuthTitleWidgets(
      {super.key,
       this.title,
      this.subtitle,
      this.titleColor,
      this.subTitleColor,
      this.titleFontSize,
      this.subTitleFontSize,  this.showLogo = true, this.logoSize});

  final String? title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final bool showLogo;
  final double? logoSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(showLogo)
         Center(child: Assets.icons.appLogo.svg(width: logoSize ?? 165.w,height: logoSize ?? 165.h)),
          if(title != null)
          CustomText(
            fontWeight: FontWeight.w600,
            top: 12.h,
            text: title ?? '',
            fontSize:titleFontSize?? 24.sp,
            color: titleColor ?? AppColors.primaryShade600,
          ),
          if(subtitle != null)...[
            SizedBox(height: 6.h),
            CustomText(
              textAlign: TextAlign.center,
              text: subtitle ?? '',
              fontSize: subTitleFontSize ?? 14.sp,
              color: subTitleColor ?? AppColors.darkShade400,
              textOverflow: TextOverflow.fade,
              fontName: FontFamily.csaction,
            ),
          ],
        ],
      ),
    );
  }
}
