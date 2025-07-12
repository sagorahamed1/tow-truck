import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    offset: Offset(0, 0)
                )
              ],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding:  EdgeInsets.all(4.r),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        title: CustomText(text: "Report", fontSize: 20.h)

      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0.3, thickness: 2, endIndent: 2),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
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

                    // Radio List
                    ...reasons.map((reason) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.textColor4E4E4E, width: 0.8),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: reason,
                              groupValue: selectedReason,
                              onChanged: (value) {
                                setState(() {
                                  selectedReason = value!;
                                });
                              },
                              activeColor: Colors.green,
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
                    )),


                    SizedBox(height: 16.h),

                    ///  ================================= "Other" TextField ==============================>
                    CustomTextField(
                      hintText: "Other",
                      maxLines: 4,
                      controller: otherController,
                    ),
                    SizedBox(height: 55.h),


                    /// ===============================> Submit Button ======================================>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 6,
                            offset: Offset(-2, 3)
                          )
                        ]
                      ),
                      child: CustomButtonTwo(
                        title: "Next",
                        onpress: () {

                        },),
                    ),
                    SizedBox(height: 47.h),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 25.h),
        ],
      ),
    );
  }

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
}
