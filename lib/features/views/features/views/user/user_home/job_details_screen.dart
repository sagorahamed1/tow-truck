import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/helpers/time_format.dart';
import 'package:towservice/helpers/toast_message_helper.dart';
import 'package:towservice/services/api_constants.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_button.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as TimeAgo;

import '../../../../../../controller/user/user_job_post_controller.dart';

class JobDetailsScreen extends StatefulWidget {
  JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  TextEditingController promoCode = TextEditingController();
  UserJobPostController userJobPostController =
      Get.put(UserJobPostController());
  RxBool loading = false.obs;
  RxDouble? discountPrice = 0.0.obs;
  RxDouble? initPromoPrice = 0.0.obs;
  RxString? promoType = "".obs;

  @override
  void initState() {
    userJobPostController.getJobDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Obx(() {
            if (userJobPostController.jobDetailsLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            final job = userJobPostController.jobDetails.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                    height: 247.h,
                    borderRadius: 12.r,
                    width: double.infinity,
                    imageUrl:
                        "${ApiConstants.imageBaseUrl}/${job.carImage ?? ""}"),
                CustomText(
                    text: "${job.providerName ?? ""}",
                    fontSize: 20.h,
                    top: 16.h,
                    bottom: 20.h),
                CustomText(text: "${job.companyName ?? ""}"),
                CustomText(text: "${job.towType}", bottom: 16.h),
                CustomText(
                    maxline: 50,
                    textAlign: TextAlign.start,
                    fontSize: 11.h,
                    text: "${job.description ?? ""}"),
                CustomText(
                    text: "Driver info",
                    top: 16.h,
                    fontSize: 16.h,
                    color: Colors.black),
                Row(
                  children: [
                    CustomNetworkImage(
                        height: 53.h,
                        boxShape: BoxShape.circle,
                        width: 53.w,
                        imageUrl:
                            "${ApiConstants.imageBaseUrl}/${job.profileImage ?? ""}"),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: "${job.providerName ?? ""}"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 14.h),
                            CustomText(
                                text:
                                    "${job.totalRating ?? ""}  |  ${job.totalRating} Ratings  |  ${job.amount ?? ""}₦",
                                fontSize: 11.h),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffE4E4E4),
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 1.5.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final Uri emailUrl = Uri(
                                  scheme: 'mailto',
                                  path: '${job.email ?? ""}',
                                  query: 'subject=Support Inquiry&body=Hello, I need assistance with...',
                                );
                                if (await launchUrl(emailUrl)) {
                                  await launchUrl(emailUrl);
                                } else {
                                  debugPrint('Could not launch email client');
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Assets.icons.messageIcon
                                      .svg(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                            // SizedBox(width: 20.w),
                            // GestureDetector(
                            //   onTap: () async {
                            //     final Uri url =
                            //         Uri.parse('tel:(${job.phone ?? ""}');
                            //     if (await launchUrl(url)) {
                            //       await launchUrl(url);
                            //     } else {
                            //       debugPrint('Could not launch phone dialer');
                            //     }
                            //   },
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         shape: BoxShape.circle),
                            //     child: Padding(
                            //       padding: EdgeInsets.all(8.r),
                            //       child: Assets.icons.callIcon.svg(),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                CustomText(
                    text: "${job.towType ?? ""}", top: 20.h, bottom: 10.h),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14.h),
                    CustomText(
                        maxline: 50,
                        textAlign: TextAlign.start,
                        fontSize: 11.h,
                        text: "${job.address ?? ""}"),
                  ],
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: job.promos?.length,
                  itemBuilder: (context, index) {
                    var promo = job.promos?[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: GestureDetector(
                        onTap: () {
                          promoCode.text = "${promo?.code ?? ""}";
                          if (promo?.type == "percent") {
                            promoType?.value = "percent";
                            initPromoPrice?.value = ((promo?.value?.toDouble() ?? 0) * job.minAmount!) / 100;
                          } else {
                            promoType?.value = "fixed";
                            initPromoPrice?.value = promo?.value?.toDouble() ?? 0.0;
                          }

                        },
                        child: Container(
                          width: double.infinity,
                          color: AppColors.primaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            child: Row(
                              children: [
                                Icon(Icons.copy,
                                    color: Colors.white, size: 16.h),
                                Expanded(
                                  child: CustomText(
                                      textAlign: TextAlign.start,
                                      left: 12.w,
                                      color: Colors.white,
                                      fontSize: 12.h,
                                      text:
                                          "“${promo?.code ?? ""}”    |   ${promo?.value ?? ""}${promo?.type == "percent" ? "%" : "₦"} OFF!   |   ${TimeAgo.format(promo?.expireDate ?? DateTime.now(), allowFromNow: true)} left "),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Promo Code Input
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: (){
                              ToastMessageHelper.showToastMessage("Please tap the promo code");
                            },
                            readOnly: true,
                            controller: promoCode,
                            decoration: InputDecoration(
                              hintText: "Select Promo Code",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Obx(
                          () => CustomButtonTwo(
                            loading: loading.value,
                            loaderIgnore: true,
                            width: 80.w,
                            fontSize: 12.h,
                            height: 40.w,
                            onpress: () async {
                              loading(true);
                              discountPrice?.value =
                                  initPromoPrice?.value ?? 0.0;
                              Future.delayed(Duration(seconds: 2));
                              loading(false);
                            },
                            title: "Apply",
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Order Summary
                    summaryRow("Order amount", "${job.amount ?? ""} ₦"),

                    Obx(() => summaryRow("Discount",
                        "${discountPrice?.value ?? job.discount ?? ""} ₦")),
                    summaryRow("Platform Fee", "${job.charge ?? ""} ₦"),
                    Divider(
                        height: 24.h,
                        thickness: 1,
                        color: Colors.grey.shade300),
                    summaryRow("Final amount",
                        "${job.minAmount! - (discountPrice!.value)} ₦",
                        isBold: true),


                    SizedBox(height: 20.h),

                    // Payment Method
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: AppColors.primaryColor),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "Pay via Wallet",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        CustomText(
                          text: "${job.minAmount! - (discountPrice!.value)} ₦",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: "This is the estimated fare. This may Vary.",
                        fontSize: 12.sp,
                        color: Colors.black87,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomButtonTwo(
                    title: "Book Now",
                    onpress: () {
                       userJobPostController.requestJobPost(providerList: [job.providerId]);
                    }),
                SizedBox(height: 80.h)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
          CustomText(
            text: value,
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
