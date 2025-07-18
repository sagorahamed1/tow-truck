import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/utils/app_constant.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';

class JobDetailsScreen extends StatelessWidget {
  JobDetailsScreen({super.key});

  TextEditingController promoCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                  height: 247.h,
                  borderRadius: 12.r,
                  width: double.infinity,
                  imageUrl:
                      "https://static.vecteezy.com/system/resources/previews/047/617/836/non_2x/realistic-truck-illustration-vector.jpg"),


              CustomText(
                  text: "Hook and Chain Tow Truck",
                  fontSize: 20.h,
                  top: 16.h,
                  bottom: 20.h),
              CustomText(text: "DHK Metro Ha 21-4542"),
              CustomText(text: "Suzuki Alto 800", bottom: 16.h),
              CustomText(
                  maxline: 50,
                  textAlign: TextAlign.start,
                  fontSize: 11.h,
                  text:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "),
              CustomText(
                  text: "Driver info",
                  top: 16.h,
                  fontSize: 16.h,
                  color: Colors.black),
              Row(
                children: [
                  CustomNetworkImage(
                      height: 53.h,
                      boxShape: BoxShape.circle,
                      width: 53.w,
                      imageUrl:
                          "https://randomuser.me/api/portraits/men/75.jpg"),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Sabbir Hossein"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 14.h),
                          CustomText(
                              text: "4.65     |   24545 Trips   |",
                              fontSize: 11.h),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(40.r),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 1.5.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Assets.icons.messageIcon
                                  .svg(color: AppColors.primaryColor),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Assets.icons.callIcon.svg(),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              CustomText(text: "Suzuki Alto 800", top: 20.h, bottom: 10.h),
              Row(
                children: [
                  Icon(Icons.location_on, size: 14.h),
                  CustomText(
                      maxline: 50,
                      textAlign: TextAlign.start,
                      fontSize: 11.h,
                      text: "Green Road, Dhanmondi, Dhaka."),
                ],
              ),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        promoCode.text = "MERN33";
                      },
                      child: Container(
                        width: double.infinity,
                        color: AppColors.primaryColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 12.w),
                          child: Row(
                            children: [
                              Icon(Icons.copy, color: Colors.white, size: 16.h),
                              CustomText(
                                  left: 12.w,
                                  color: Colors.white,
                                  fontSize: 12.h,
                                  text:
                                      "“MERN33”      |     33% OFF!       |       2 days left "),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Promo Code Input
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: promoCode,
                          decoration: InputDecoration(
                            hintText: "Enter Promo Code",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: CustomText(
                          text: "Apply",
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Order Summary
                  summaryRow("Order amount", "39.44 ₦"),
                  summaryRow("Discount", "-9.44 ₦"),
                  summaryRow("Platform Fee", "30.44 ₦"),
                  Divider(
                      height: 24.h, thickness: 1, color: Colors.grey.shade300),
                  summaryRow("Final amount", "30.44 ₦", isBold: true),

                  SizedBox(height: 20.h),

                  // Payment Method
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined,
                          color: AppColors.primaryColor),
                      SizedBox(width: 8.w),
                      CustomText(
                        text: "Pay via Wallet",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      CustomText(
                        text: "30.44 ₦",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "This is the estimated fare. This may Vary.",
                      fontSize: 12.sp,
                      color: Colors.black87,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),


              CustomButtonTwo(title: "Book Now", onpress: () {

              }),



              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
          CustomText(
            text: value,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
