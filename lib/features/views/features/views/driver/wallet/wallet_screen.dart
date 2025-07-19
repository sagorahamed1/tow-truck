import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:towservice/widgets/custom_text_field.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  int trans = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 238.h,
                width: 238.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffB0BFBA), width: 30.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        text: "Your Balance",
                        fontSize: 18.h,
                        color: Colors.black),
                    CustomText(
                        text: "₦ 1000",
                        fontSize: 28.h,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              ),
            ),

            // CustomText(text: "Show Breakdown", fontSize: 18.h, color: Colors.black, top: 10.h)

            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () {
                TextEditingController amountCtrl = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                              text: "Add Money",
                              fontSize: 16.h,
                              fontWeight: FontWeight.w600,
                              top: 20.h,
                              bottom: 12.h),
                          SizedBox(height: 24.h),
                          CustomTextField(
                              keyboardType: TextInputType.number,
                              controller: amountCtrl,
                              borderColor: AppColors.primaryColor,
                              borderRadio: 28.r,
                              hintText: "Enter Amount",
                              labelText: "Enter Amount"),
                          SizedBox(height: 40.h),
                          CustomButtonTwo(
                            title: "Confirm",
                            onpress: () {},
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.primaryColor, width: 3.r),
                    borderRadius: BorderRadius.circular(16.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.addMoneyIcon
                          .svg(color: AppColors.primaryColor),
                      CustomText(
                          text: "Add Money",
                          color: AppColors.primaryColor,
                          left: 12.w,
                          fontSize: 16.h,
                          fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border.all(color: AppColors.primaryColor, width: 3.r),
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.icons.addMoneyIcon.svg(color: Colors.white),
                    CustomText(
                        text: "Withdraw",
                        color: Colors.white,
                        left: 12.w,
                        fontSize: 16.h,
                        fontWeight: FontWeight.w500)
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Payment History", fontSize: 18.h),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.walletHistoryScreen);
                    },
                    child: CustomText(
                        text: "See all", color: AppColors.primaryColor)),
              ],
            ),

            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: trans,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F3EC),
                      border: Border.all(color: Color(0xffE7DBC5)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Row(
                        children: [
                          index.isOdd
                              ? Assets.icons.rightTopIcon.svg()
                              : Assets.icons.leftBottomIcon.svg(),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "#G68F78"),
                              CustomText(
                                  text: "today at 09:20 AM",
                                  color: AppColors.primaryColor)
                            ],
                          ),
                          Spacer(),
                          CustomText(
                              text: "-₦570.00",
                              color: index.isOdd ? Colors.red : Colors.black)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
