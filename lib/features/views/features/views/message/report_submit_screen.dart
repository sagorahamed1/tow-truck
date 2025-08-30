import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/controller/profile_controller.dart';
import 'package:towservice/helpers/toast_message_helper.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import '../../../../../controller/user/user_job_post_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_text_field.dart';

class ReportSubmitScreen extends StatefulWidget {
  ReportSubmitScreen({super.key});

  @override
  State<ReportSubmitScreen> createState() => _ReportSubmitScreenState();
}

class _ReportSubmitScreenState extends State<ReportSubmitScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  UserJobPostController userJobPostController = Get.put(UserJobPostController());

  final TextEditingController otherController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Report",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20.h),


            CustomText(
              text: "Find Support or Report User",
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor4E4E4E,
            ),
            SizedBox(height: 2.h),
            CustomText(
              text: "Help us understanding what’s happening ",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor4E4E4E,
            ),
            SizedBox(height: 28.h),



            Container(
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.primaryColor, width: 0.8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 20.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 10.h,
                          width: 10.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    child: Text(
                      "${Get.arguments["selectItem"]}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor4E4E4E,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20.h),
            CustomTextField(
              hintText: "Write you complaint",
              maxLines: 4,
              labelText: "Describe your complaint",
              controller: otherController,
              minLines: 4,
            ),


            Spacer(),

            CustomButtonTwo(
              title: "Submit",
              onpress: () {
                profileController.role == "user" ?
                Get.offAllNamed(AppRoutes.userBottomNavBar)
                :
                Get.offAllNamed(AppRoutes.customNavBarScreen);


                ToastMessageHelper.showToastMessage("Your report summited");
              },
            ),


            SizedBox(height: 100.h),

          ],
        ),
      ),
    );
  }
}
