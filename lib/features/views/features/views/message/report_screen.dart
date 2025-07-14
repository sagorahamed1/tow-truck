import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_text.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_text_field.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String selectedReason = 'Hate Speech';
  final TextEditingController otherController = TextEditingController();

  final List<String> reasons = [
    'Hate Speech',
    'Nudity or Sexual Content',
    'Threat',
    'Harassment',
    'Diffamation',
    'Fraud Or Scam',
    'Something Else',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Report",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: ListView.builder(
                itemCount: reasons.length + 4,
                // title + subtitle + reasons + textfield + button
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    );
                  } else if (index <= reasons.length) {
                    final reason = reasons[index - 1];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedReason = reason;
                          });
                        },
                        child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: selectedReason == reason ? AppColors.primaryColor : AppColors.textColor4E4E4E, width: 0.8),
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
                                    color: selectedReason == reason ? AppColors.primaryColor : AppColors.textColor4E4E4E,
                                    width: 1.5,
                                  ),
                                ),
                                child: selectedReason == reason
                                    ? Center(
                                        child: Container(
                                          height: 10.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              Expanded(
                                child: Text(
                                  reason,
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
                      ),
                    );
                  } else if (index == reasons.length + 1) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: CustomTextField(
                        hintText: "Other",
                        maxLines: 4,
                        controller: otherController,
                      ),
                    );
                  } else if (index == reasons.length + 2) {
                    return Padding(
                      padding: EdgeInsets.only(top: 55.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 6,
                                offset: Offset(-2, 3))
                          ],
                        ),
                        child: CustomButtonTwo(
                          title: "Next",
                          onpress: () {
                            Get.toNamed(AppRoutes.reportSubmitScreen, arguments: {
                              "selectItem" : selectedReason
                            });
                          },
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(height: 47.h);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }
}
