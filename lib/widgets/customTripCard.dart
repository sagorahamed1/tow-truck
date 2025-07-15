import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global/custom_assets/assets.gen.dart';
import '../utils/app_colors.dart';
import 'custom_buttonTwo.dart';
import 'custom_network_image.dart';
import 'custom_text.dart';

class Customtripcard extends StatelessWidget {
  const Customtripcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.grey.shade400,
                offset: Offset(1, 1))
          ]),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF7F3EC),
                  borderRadius: BorderRadius.circular(4.r)),
              child: Row(
                children: [
                  CustomNetworkImage(
                    height: 49.h,
                    width: 49.w,
                    boxShape: BoxShape.circle,
                    imageUrl:
                    "https://randomuser.me/api/portraits/women/79.jpg",
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Najma"),
                      Row(
                        children: [
                          CustomText(
                              text: "★★★★★", color: Color(0xffFFCE31)),
                          SizedBox(width: 4.w),
                          CustomText(text: "5(2)"),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "\$ 20", fontWeight: FontWeight.w600),
                      CustomText(text: "3.3 km"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Assets.icons.pickUpIcon.svg(),
                CustomText(
                    fontSize: 11.h,
                    text: " PICK UP        : Block B, Banasree, Dhaka",
                    fontWeight: FontWeight.w500),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: AppColors.primaryColor, size: 15.h),
                CustomText(
                    fontSize: 11.h,
                    text: "DROP OFF    : Dhanmondi, Dhaka",
                    fontWeight: FontWeight.w500),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                        fontSize: 11.h,
                        text: "Car Type: ", fontWeight: FontWeight.w500),
                    CustomText(
                        fontSize: 11.h,
                        text: "Jeep ", fontWeight: FontWeight.w300),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                        fontSize: 11.h,
                        text: "Vehicle Issue: ",
                        fontWeight: FontWeight.w500),
                    CustomText(
                        fontSize: 11.h,
                        text: "Accident", fontWeight: FontWeight.w300),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    fontSize: 11.h,
                    text: "Vehicle Issue: ", fontWeight: FontWeight.w500),
                Expanded(
                  child: CustomText(
                      textAlign: TextAlign.start,
                      maxline: 4,
                      fontSize: 11.h,
                      text:
                      "Figma ipsum component variant main layer. Opacity text arrow link move plugin bold follower. Clip flows plugin figma blur frame frame.",
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),


            Divider(),


            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                      height: 35.h,
                      color: Colors.red,
                      boderColor: Colors.red,
                      title: "Decline", onpress: () {

                  }),
                ),


                SizedBox(width: 40.w),


                Expanded(
                  flex: 1,
                  child: CustomButtonTwo(
                      height: 35.h,
                      title: "Accept", onpress: () {

                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
