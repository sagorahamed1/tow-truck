import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/utils/app_colors.dart';

class PrivacyAndTermsHelper extends StatelessWidget {
  PrivacyAndTermsHelper({Key? key}) : super(key: key);

  final PrivacyController _controller = Get.find<PrivacyController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() => Checkbox(
          value: _controller.isChecked.value,
          onChanged: _controller.toggleCheckbox,
          activeColor: AppColors.primaryShade600,
        )),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.darkColor,
              ),
              children: [
                const TextSpan(text: "I agree with "),
                TextSpan(
                  text: "terms of services ",
                  style: TextStyle(
                    color: AppColors.primaryShade600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //Get.toNamed(AppRoutes.termsScreen);
                    },
                ),
                const TextSpan(text: "and "),
                TextSpan(
                  text: "privacy policy.",
                  style: TextStyle(
                    color: AppColors.primaryShade600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //Get.toNamed(AppRoutes.privacyPolicyScreen); // example navigation
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PrivacyController extends GetxController {
  var isChecked = false.obs;

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}

