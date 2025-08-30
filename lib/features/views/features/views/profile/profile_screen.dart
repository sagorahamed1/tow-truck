import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/controller/profile_controller.dart';
import 'package:towservice/helpers/prefs_helper.dart';
import 'package:towservice/routes/app_routes.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/services/socket_services.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/utils/app_constant.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../widgets/custom_buttonTwo.dart';
import '../../../../../widgets/custom_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    profileController.getUserLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/profileBg.png"),
                    fit: BoxFit.cover),
              ),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(height: 80.h),
                    Stack(
                      children: [
                        CustomNetworkImage(
                            border: Border.all(
                                color: Color(0xffFAEFD7), width: 2.5),
                            height: 100.h,
                            width: 100.w,
                            boxShape: BoxShape.circle,
                            imageUrl:
                                "${ApiConstants.imageBaseUrl}${profileController.image.value}"),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Assets.icons.verifyBedgeIcon
                              .svg(height: 32.h, width: 32.w),
                        )
                      ],
                    ),
                    CustomText(
                        text: "${profileController.name.value}",
                        color: Colors.white,
                        fontSize: 16.h,
                        top: 9.h,
                        bottom: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar(
                          initialRating: int.parse(
                                  profileController.rating == ""
                                      ? "0"
                                      : profileController.rating.toString())
                              .toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Icon(Icons.star_half, color: Colors.amber),
                            empty: Icon(Icons.star_border, color: Colors.amber),
                          ),
                          itemSize: 14.h,
                          itemPadding: EdgeInsets.only(right: 4.w, bottom: 8.h),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        CustomText(
                            text: "5 (${profileController.rating ?? 0})",
                            color: Colors.white,
                            bottom: 8.h),
                      ],
                    ),
                    CustomText(
                        text: "${profileController.email.value}",
                        color: Colors.white,
                        fontSize: 16.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Color(0xffFEFDF9),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: Offset(-1, 2))
                  ]),
              child: Column(
                children: [
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfileScreen, arguments: {
                        "name": profileController.name.value,
                        "phone": profileController.phone.value,
                        "email": profileController.email.value,
                        "role": profileController.role.value,
                        "address": profileController.address.value,
                        "image": profileController.image.value,
                        "dateOfBirth": profileController.dateOfBirth.value
                      })?.then((_) {
                        profileController.getUserLocalData();
                      });
                    },
                    title: "Personal Info",
                    icon: Assets.icons.profile.svg(),
                  ),
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.supportScreen);
                    },
                    title: "Customer Support",
                    icon: Assets.icons.supportIcon.svg(),
                  ),
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.notificationScreen);
                    },
                    title: "Notifications",
                    icon: Assets.icons.notificationIcon
                        .svg(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),

            if(profileController.role.value == "provider")
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Color(0xffFEFDF9),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: Offset(-1, 2))
                  ]),
              child: Column(
                children: [
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.userBottomNavBar);
                    },
                    title: "Find Tow Services",
                    icon: Assets.icons.findTowServiceIcon.svg(),
                  ),
                ],
              ),
            ),




            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Color(0xffFEFDF9),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: Offset(-1, 2))
                  ]),
              child: Column(
                children: [
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.settingScreen,
                          arguments: {"email": profileController.email.value});
                    },
                    title: "Setting",
                    icon: Assets.icons.settingIcon.svg(),
                  ),
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                        "title": "Term & Condition",
                      });
                    },
                    title: "Term & Condition",
                    icon: Assets.icons.termIcon.svg(),
                  ),
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                        "title": "Privacy Policy",
                      });
                    },
                    title: "Privacy Policy",
                    icon: Assets.icons.privacyIcon.svg(),
                  ),
                  _customCart(
                    onTap: () {
                      Get.toNamed(AppRoutes.privacyPolicyAllScreen, arguments: {
                        "title": "About Us",
                      });
                    },
                    title: "About Us",
                    icon: Assets.icons.aboutUsIcon.svg(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: Color(0xffFEFDF9),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: Offset(-1, 2))
                  ]),
              child: Column(
                children: [
                  _customCart(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                    text: "Log Out",
                                    fontSize: 16.h,
                                    fontWeight: FontWeight.w600,
                                    top: 20.h,
                                    bottom: 12.h),
                                Divider(),
                                SizedBox(height: 12.h),
                                CustomText(
                                  maxline: 2,
                                  bottom: 20.h,
                                  text: "Do you want to log out ?",
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomButtonTwo(
                                          height: 50.h,
                                          title: "Cancel",
                                          onpress: () {},
                                          color: Colors.transparent,
                                          fontSize: 11.h,
                                          loaderIgnore: true,
                                          boderColor: Colors.black,
                                          titlecolor: Colors.black),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      flex: 1,
                                      child: CustomButtonTwo(
                                          loading: false,
                                          loaderIgnore: true,
                                          color: Colors.red,
                                          boderColor: Colors.red,
                                          height: 50.h,
                                          title: "Log Out",
                                          onpress: () async {
                                            await PrefsHelper.remove(
                                                AppConstants.image);
                                            await PrefsHelper.remove(
                                                AppConstants.name);
                                            await PrefsHelper.remove(
                                                AppConstants.address);
                                            await PrefsHelper.remove(
                                                AppConstants.email);
                                            await PrefsHelper.remove(
                                                AppConstants.isLogged);
                                            await PrefsHelper.remove(
                                                AppConstants.role);
                                            await PrefsHelper.remove(
                                                AppConstants.number);
                                            await PrefsHelper.remove(
                                                AppConstants.bearerToken);
                                            await PrefsHelper.remove(
                                                AppConstants.userId);
                                            await PrefsHelper.remove(
                                                AppConstants.dateOfBirth);


                                            SocketServices socket = SocketServices();
                                            socket.disconnect(
                                              isManual: true
                                            );
                                            Get.offAllNamed(
                                                AppRoutes.roleScreen);
                                          },
                                          fontSize: 11.h),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    title: "Log Out",
                    icon: Assets.icons.logOutIcon.svg(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h)
          ],
        ),
      ),
    );
  }

  Widget _customCart(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
            child: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: icon,
                    )),
                CustomText(
                    text: "$title", color: AppColors.primaryColor, left: 16.w),
                Spacer(),
                Assets.icons.rightArrow.svg(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
