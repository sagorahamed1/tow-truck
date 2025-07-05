
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/views/widget/widgets.dart';

import '../../utils/utils.dart';



class ColoredHeader extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const ColoredHeader({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: CustomText(
          text: text,
          fontsize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
          textAlign: textAlign,
        ),
      ),
    );
  }
}
