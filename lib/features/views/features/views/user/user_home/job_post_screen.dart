import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location_picker_text_field/open_street_location_picker.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';

import '../../../../../../controller/current_location_controller.dart';
import '../../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/custom_text_field.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  CurrentLocationController controller = Get.put(CurrentLocationController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String selectedType = 'Sedan';
  TextEditingController carCtrl = TextEditingController();
  TextEditingController carSelectIdCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController locationName = TextEditingController();

  double distance = 0;
  double lat = 0;
  double log = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: "Tow Service Booking"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Assets.icons.addMoneyIcon.svg(),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: AppColors.primaryShade600),
                                    color: const Color(0xffE6E6FF)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8.w),
                                      Icon(Icons.location_on,
                                          color: AppColors.primaryShade600),
                                      Expanded(
                                        child: CustomText(
                                            textAlign: TextAlign.start,
                                            text: "{routerData[" "]}",
                                            color: AppColors.primaryShade600,
                                            left: 8.w),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: const Color(0xffE6E6FF)),
                                child: LocationPicker(
                                  label: "",
                                  controller: locationName,
                                  onSelect: (data) {
                                    locationName.text = data.displayname;
                                    distance =
                                        controller.calculateDistanceInMiles(
                                            data.latitude, data.longitude);
                                    log = data.longitude;
                                    lat = data.latitude;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60.h),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.primaryColor),
                      child: Padding(
                        padding: EdgeInsets.all(50.r),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: CustomText(
                                      maxline: 2,
                                      textAlign: TextAlign.start,
                                      text: "{routerData[" "]}",
                                      color: Colors.white,
                                      left: 7.w),
                                )
                              ],
                            ),
                            Assets.icons.addMoneyIcon
                                .svg(height: 30.h, color: Colors.green),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                ),
                                Expanded(
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      text: locationName.text,
                                      color: Colors.white,
                                      maxline: 2,
                                      left: 7.w),
                                )
                              ],
                            ),
                            CustomText(
                                text:
                                    "Total Distance: ${distance.toStringAsFixed(2)} Miles",
                                color: Colors.white,
                                fontSize: 16.h,
                                top: 20.h)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
