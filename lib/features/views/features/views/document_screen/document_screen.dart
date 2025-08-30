import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Your documents"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            DocumentItem(
              icon: Assets.icons.nidIcon.svg(),
              title: "NID/Tax ID",
              status: "Uploaded",
              onTap: () {
                Get.toNamed(AppRoutes.nationalIDScreen, arguments: {
                  "appBarTitle": "National ID",
                  "textEditCtrlTitle": "National ID No",
                  "image1": "Upload your National ID picture (Front)",
                  "image2": "Upload your National ID picture (Back)"
                });
              },
            ),
            DocumentItem(
                onTap: () {
                  Get.toNamed(AppRoutes.nationalIDScreen, arguments: {
                    "appBarTitle": "Driving License",
                    "textEditCtrlTitle": "Driving License No",
                    "image1": "Upload Your Driving License picture (Front)",
                    "image2": "Upload Your Driving License picture (Back)"
                  });
                },
                icon: Assets.icons.drivingIcon.svg(),
                title: "Driving License",
                status: "Uploaded"),
            DocumentItem(
                onTap: () {
                  Get.toNamed(AppRoutes.nationalIDScreen, arguments: {
                    "appBarTitle": "Car Registration",
                    "textEditCtrlTitle": "Car Number plate No",
                    "image1": "Upload your Registration card picture ",
                    "image2": "Upload your Car number plate picture "
                  });
                },
                icon: Assets.icons.carRegistrationIcon.svg(),
                title: "Car Registration",
                status: "Uploaded"),
            DocumentItem(
                onTap: () {
                  Get.toNamed(AppRoutes.nationalIDScreen, arguments: {
                    "appBarTitle": "Driver & Car Picture",
                    "textEditCtrlTitle": "N/A",
                    "image1": "Your picture ",
                    "image2": "Your car picture "
                  });
                },
                icon: Assets.icons.dirverAndCarPictureIcon.svg(),
                title: "Driver & Car Picture",
                status: "Uploaded"),
            SizedBox(height: 150.h),
            CustomButtonTwo(
                title: "Submit",
                onpress: () {
                  Get.toNamed(AppRoutes.loginScreen);
                })
          ],
        ),
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final String status;
  final VoidCallback? onTap;

  const DocumentItem({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          children: [
            icon,
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: title, color: const Color(0xff4E4E4E)),
                CustomText(text: status),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
