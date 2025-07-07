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
      this.subTitleFontSize,  this.showLogo = true});

  final String? title;
  final String? subtitle;
  final Color? titleColor;
  final Color? subTitleColor;
  final double? titleFontSize;
  final double? subTitleFontSize;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(showLogo)
       Assets.icons.appLogo.svg(),
        if(title != null)
        CustomText(
          fontWeight: FontWeight.w600,
          top: 12.h,
          text: title ?? '',
          fontSize:titleFontSize?? 26.sp,
          color: titleColor ?? AppColors.primaryShade600,
        ),
        if(subtitle != null)...[
          SizedBox(height: 6.h),
          CustomText(
            textAlign: TextAlign.start,
            text: subtitle ?? '',
            fontSize: subTitleFontSize ?? 14.sp,
            color: subTitleColor ?? AppColors.darkShade400,
            textOverflow: TextOverflow.fade,
            fontName: FontFamily.csaction,
          ),
        ],
      ],
    );
  }
}
