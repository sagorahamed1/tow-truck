import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notifications"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Assets.icons.notificationIcon
                                .svg(color: Colors.white),
                          )),


                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "Account Create Successfully!", fontSize: 16.h),


                            CustomText(
                              textAlign: TextAlign.start,
                                maxline: 3,
                                text:
                                "Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae",
                                fontSize: 11.h),
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
