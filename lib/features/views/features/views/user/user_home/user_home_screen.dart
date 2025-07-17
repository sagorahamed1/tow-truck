import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/routes/app_routes.dart';

import '../../../../../../controller/current_location_controller.dart';
import '../../../../../../controller/live_location_change_controller.dart';
import '../../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../../helpers/toast_message_helper.dart';
import '../../../../../../widgets/custom_network_image.dart';
import '../../../../../../widgets/custom_text.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  CurrentLocationController controller = Get.put(CurrentLocationController());
  LiveLocationChangeController liveLocationChangeController =
      Get.put(LiveLocationChangeController());

  @override
  void initState() {
    controller.getCurrentLocation();
    liveLocationChangeController.listenToLocationChanges();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.address.value == "") {
      print("======================================= do not have address");
      controller.getCurrentLocation();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.only(left: 10.w),
          child: CustomNetworkImage(
              border: Border.all(color: Color(0xffFAEFD7), width: 2.5),
              height: 100.h,
              width: 100.w,
              boxShape: BoxShape.circle,
              imageUrl: "https://randomuser.me/api/portraits/men/75.jpg"),
        ),


        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(text: "Henry Silver", fontSize: 17.h, color: Colors.black),
            CustomText(text: "Dhaka, Banasree", fontSize: 12.h)


          ],
        ),

      ),



      body: Column(
        children: [
          Assets.images.customerHomeScreenImage
              .image(fit: BoxFit.cover, colorBlendMode: BlendMode.darken),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 44.h),
                    Row(
                      children: [
                        Assets.icons.logOutIcon
                            .svg(color: Colors.white, height: 50.h),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: Colors.black),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              CustomText(text: "Your location", color: Colors.black),
                              const Spacer()
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () {
                        controller.isLoading.value;
                        return GestureDetector(
                          onTap: () {
                            if (controller.address.value.isEmpty) {
                              // context.pushNamed(AppRoutes.customerSelectCarScreen,
                              //     extra: {
                              //       "title": "Tow Truck",
                              //       "address" : "${controller.address.value}"
                              //     });

                              Get.toNamed(AppRoutes.jobPostScreen, arguments: {
                                "address" : 'address'

                              });


                            } else {
                              ToastMessageHelper.showToastMessage(
                                  "Please wait 10 seconds while we fetch your location. Then try again.");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: Colors.black)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 8.h),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  CustomText(
                                      text: "Choose your location", color: Colors.black),
                                  const Spacer(),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
