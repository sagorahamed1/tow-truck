import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_text.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Customer Support",),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // spacing: 10.h,
            children: [
              Image.asset("assets/images/support.png", height: 233.h, width: 257.w),

              CustomText(
                fontSize: 16.h,
                top: 20.h,
                text:
                "If you face any kind of problem with our service feel free to contact us.",
              ),
              SizedBox(height: 20.h),

              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse('tel:(609)327-7992');
                  if (await launchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    debugPrint('Could not launch phone dialer');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.phone,
                          size: 17.h,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomText(text: "(609)327-7992"),
                  ],
                ),
              ),


              SizedBox(height: 12.h),

              InkWell(
                onTap: () async {
                  final Uri emailUrl = Uri(
                    scheme: 'mailto',
                    path: 'shina@gmail.com',
                    query: 'subject=Support Inquiry&body=Hello, I need assistance with...',
                  );
                  if (await launchUrl(emailUrl)) {
                    await launchUrl(emailUrl);
                  } else {
                    debugPrint('Could not launch email client');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.email,
                          size: 17.h,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomText(text: "shina@gmail.com"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
