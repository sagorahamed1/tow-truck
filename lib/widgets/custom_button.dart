import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/global/custom_assets/fonts.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_container.dart';
import 'package:towservice/widgets/custom_text.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.suffixIcon,
    this.child,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.fontWeight,
    this.fontSize,
    this.fontName,
    required this.onPressed,
    this.radius,
    this.prefixIcon,
    this.bordersColor,
    this.suffixIconShow = false,
    this.prefixIconShow = false,
    this.title,
    this.iconHeight,
    this.iconWidth,
    this.elevation = false,
    this.showlinearColor = true,
  });

  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final Widget? child;
  final String? label;
  final Widget? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? radius;
  final String? fontName;
  final VoidCallback? onPressed;
  final Color? bordersColor;
  final bool suffixIconShow;
  final bool prefixIconShow;
  final double? iconHeight;
  final double? iconWidth;
  final bool elevation;
  final bool showlinearColor;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      linearColors: showlinearColor
          ? [
        const Color(0xff488686),
        const Color(0xff2B5151),
      ]
          : null,
      elevation: elevation,
      onTap: onPressed,
      color: backgroundColor ?? AppColors.primaryColor,
      height: height ?? 52.h,
      width: width ?? double.infinity,
      radiusAll: radius ?? 100.r,
      bordersColor: bordersColor ?? AppColors.darkShade100,
      child: child ??
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Prefix Icon
                if (prefixIcon != null || prefixIconShow)
                  ...[
                    Icon(
                      prefixIcon ?? Icons.arrow_back,
                      size: 18.r,
                      color: foregroundColor ?? Colors.white,
                    ),
                    SizedBox(width: 8.w),
                  ],

                /// Optional title widget
                if (title != null) title!,

                /// Label
                if (label != null)
                  Flexible(
                    child: CustomText(
                      text: label!,
                      color: foregroundColor ?? Colors.white,
                      fontName: fontName ?? FontFamily.csaction,
                      fontSize: fontSize ?? 18.sp,
                    ),
                  ),

                /// Suffix Icon
                if (suffixIcon != null || suffixIconShow)
                  ...[
                    SizedBox(width: 8.w),
                    suffixIcon ??
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18.r,
                          color: foregroundColor ?? Colors.white,
                        ),
                  ],
              ],
            ),
          ),
    );
  }
}
