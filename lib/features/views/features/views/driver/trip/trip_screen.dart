import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/widgets.dart';
import '../../../../../../widgets/custom_text.dart';

class TripScreen extends StatefulWidget {
   TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int selectedBtnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            // Tab Bar
            Row(
              children: [
                Expanded(
                  child: CustomButtonTwo(
                    boderColor: AppColors.primaryColor,
                    color: selectedBtnIndex == 0 ?  Colors.transparent : AppColors.primaryColor ,
                    titlecolor: selectedBtnIndex == 0 ?  AppColors.primaryColor : Colors.white,
                    height: 40.h,
                    borderRadius: 4.r,
                    title: "Ongoing",
                    onpress: () {
                      setState(() {
                        selectedBtnIndex = 1;
                      });
                    },
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: CustomButtonTwo(
                    boderColor: AppColors.primaryColor,
                    color: selectedBtnIndex == 1 ? Colors.transparent : AppColors.primaryColor,
                    titlecolor:  selectedBtnIndex == 1 ? AppColors.primaryColor : Colors.white,
                    height: 40.h,
                    borderRadius: 4.r,
                    title: "Completed",
                    onpress: () {
                      print("==================");
                      setState(() {
                        selectedBtnIndex = 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(color: AppColors.primaryColor,height: 1.5.h),
            SizedBox(height: 10.h),

            // List
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                padding: EdgeInsets.only(top: 8.h),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: CompletedCard(
                        onTap: () {
                          Get.toNamed(AppRoutes.tripDetailsScreen);
                        },
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedCard extends StatelessWidget {
  final VoidCallback? onTap;
  const CompletedCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 2.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          // border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(1, 1),
                blurRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date + Profile Image
          Row(
            children: [
              Expanded(
                child: CustomText(
                  text: "05 July 2024, 04:40 PM",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                ),
              ),
              CustomNetworkImage(
                  imageUrl: "https://randomuser.me/api/portraits/men/75.jpg",
                  boxShape: BoxShape.circle,
                  height: 40.h,
                  width: 40.w)
            ],
          ),
          SizedBox(height: 8.h),

          // Pickup location
          Row(
            children: [
              Assets.icons.pickUpIcon.svg(),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  text: "  Block B, Banasree, Dhaka.",
                  fontSize: 13.sp,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Destination location
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 18.sp, color: AppColors.darkColor),
              SizedBox(width: 6.w),
              Expanded(
                child: CustomText(
                  text: "Green Road, Dhanmondi, Dhaka.",
                  fontSize: 13.sp,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          CustomButtonTwo(
              height: 36.h,
              color: Colors.transparent,
              titlecolor: Colors.black,
              title: "View Details",
              onpress: onTap ?? (){})
        ],
      ),
    );
  }
}
