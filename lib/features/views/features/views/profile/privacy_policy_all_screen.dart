import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:towservice/controller/privacy_policy_controller.dart';
import 'package:towservice/helpers/privacy_and_terms_helper.dart';
import 'package:towservice/widgets/custom_loader.dart';

import '../../../../../widgets/custom_app_bar.dart';
import '../../../../../widgets/custom_text.dart';


class PrivacyPolicyAllScreen extends StatefulWidget {
  const PrivacyPolicyAllScreen({super.key});

  @override
  State<PrivacyPolicyAllScreen> createState() => _PrivacyPolicyAllScreenState();
}

class _PrivacyPolicyAllScreenState extends State<PrivacyPolicyAllScreen> {

  PrivacyPolicyController policyController = Get.put(PrivacyPolicyController());

  @override
  void initState() {
    policyController.getPrivacyPolicyAll(
        url: Get.arguments["title"] == "Term & Condition"
            ? "/setting/terms-conditions" :  Get.arguments["title"] == "Privacy Policy"
            ? "/setting/privacy-policy" : "/setting/about-us");
    super.initState();
  }


  @override
  void dispose() {
    policyController.valueText.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${Get.arguments["title"]}"),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Obx(
              ()=>
                  policyController.valueText.isEmpty ? CustomLoader(top: 300.h) :
                  Column(
              children: [

                SizedBox(height: 20.h),


                // CustomText(
                //   color: Colors.black,
                //   maxline: 1000,
                //   textAlign: TextAlign.start,
                //   text: "${policyController.valueText.value}",)
                //


                HtmlWidget(
                    "${policyController.valueText.value}",
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 14.h,

                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
