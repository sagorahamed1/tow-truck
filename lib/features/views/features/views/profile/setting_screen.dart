import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/custom_text_field.dart';


class SettingScreen extends StatelessWidget {
   SettingScreen({super.key});

  TextEditingController oldPassCtrl = TextEditingController();
  TextEditingController newPassCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 30.h),


            _customCartItem(
                title: "Change Password",
                icon: Assets.icons.lock.svg(),
                onTap: () {




                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            CustomText(text: "Password Change", fontSize: 18.h, bottom: 24.h),


                            CustomTextField(
                              isPassword: true,
                              controller: oldPassCtrl,
                              hintText: "Old Password",
                              borderColor: AppColors.primaryColor,
                              hintextColor: Colors.black,
                              contentPaddingVertical: 10.h,
                              borderRadio: 40,
                            ),



                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomText(text: "Forgot Password?", color: Colors.black87),
                            ),

                            SizedBox(height: 16.h),



                            CustomTextField(
                              isPassword: true,
                              controller: newPassCtrl,
                              hintText: "New Password",
                              borderColor: AppColors.primaryColor,
                              hintextColor: Colors.black,
                              contentPaddingVertical: 10.h,
                              borderRadio: 40,
                            ),




                            CustomTextField(
                              isPassword: true,
                              controller: confirmPassCtrl,
                              hintText: "Confirm Password",
                              borderColor: AppColors.primaryColor,
                              hintextColor: Colors.black,
                              borderRadio: 40,
                              contentPaddingVertical: 10.h,
                            ),



                            SizedBox(height: 40.h),

                            CustomButtonTwo(title: "Save Password", onpress: () {

                            })
                          ],
                        ),
                      );
                    },
                  );


                }),





            _customCartItem(
                title: "Delete Account",
                icon: Assets.icons.deleteIcon.svg(),
                onTap: () {


                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                                text: "Delete Account",
                                fontSize: 16.h,
                                fontWeight: FontWeight.w600,
                                top: 20.h,
                                bottom: 12.h),
                            Divider(),
                            SizedBox(height: 12.h),
                            CustomText(
                              maxline: 2,
                              bottom: 20.h,
                              text: "Do you want to delete your account?",
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
                                      title: "Delete",
                                      onpress: () {
                                        Get.back();
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

                }),



            SizedBox(height: 80.h)


          ],
        ),
      ),
    );
  }

  Widget _customCartItem(
      {required String title,
      required Widget icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.primaryColor)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                icon,
                CustomText(text: "$title", color: Colors.black, left: 16.w),
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
