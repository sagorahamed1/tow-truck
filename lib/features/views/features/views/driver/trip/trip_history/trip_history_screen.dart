import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_container.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class TripHistoryScreen extends StatelessWidget {
  TripHistoryScreen({super.key});

  TextEditingController supportNoteCtrl = TextEditingController();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(23.8103, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final List<Map<String, dynamic>> paymentDetails = [
    {
      'paymentTitle': "Order Value",
      'amount': '39.44 ₦',
    },
    {
      'paymentTitle': "Discount",
      'amount': '39.44 ₦',
    },
    {
      'paymentTitle': "vat Paid by rider",
      'amount': '39.44 ₦',
    },
    {
      'paymentTitle': "Total amount with Tax",
      'amount': '39.44 ₦',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Trip History"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomContainer(
                  // paddingHorizontal: 24.r,
                  height: 180.h,
                  radiusAll: 12.r,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 4,
                        spreadRadius: 0)
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 12.0,
                      ),
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(2, 4))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomText(text: "Najma", fontSize: 16.h),
                            CustomText(
                                text: "Ongoing",
                                fontSize: 11.h,
                                color: AppColors.primaryColor),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "09 Aug,2024", fontSize: 16.h),
                            CustomText(text: "08:07 PM", fontSize: 11.h),
                          ],
                        ),
                        SizedBox(width: 16.w)
                      ],
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.symmetric(vertical: 8.h),
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 5,
                            offset: Offset(2, 4))
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: "Your Trip", fontWeight: FontWeight.w600),
                        Row(
                          children: [
                            Assets.icons.pickUpIcon.svg(),
                            CustomText(
                                text: " Block B, Banasree, Dhaka.",
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                        Container(
                            height: 20.h, width: 1.5.w, color: Colors.grey),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12.h),
                            CustomText(
                                text: " Green Road, Dhanmondi, Dhaka.",
                                fontWeight: FontWeight.w500)
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Distance :"),
                            CustomText(text: "5.9 KM", right: 20.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomContainer(
                  paddingAll: 16.r,
                  // height: 36.h,
                  radiusAll: 16.r,
                  width: double.infinity,
                  color: AppColors.paymentCardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // spacing: 8,
                        children: [
                          Icon(
                            Icons.wallet,
                            size: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                          CustomText(
                            text: 'Payment',
                            fontSize: 12.sp,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16.sp,
                          )
                        ],
                      ),
                      CustomText(
                        text: '34.52 ₦',
                        fontSize: 11.sp,
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: paymentDetails.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.only(bottom: 8.h),
                    itemBuilder: (context, index) {
                      final payment = paymentDetails[index];
                      return Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: payment['paymentTitle']),
                            CustomText(text: payment['amount'])
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 26.h),
                CustomContainer(
                  width: double.infinity,
                  paddingAll: 8.r,
                  radiusAll: 16.r,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 4),
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 2)
                  ],
                  child: Row(
                    children: [
                      CustomNetworkImage(
                          height: 53.h,
                          boxShape: BoxShape.circle,
                          width: 53.w,
                          imageUrl:
                              "https://randomuser.me/api/portraits/men/75.jpg"),
                      SizedBox(width: 10.w),
                      CustomText(text: "Sabbir Hossein"),
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Assets.icons.messageIcon
                                      .svg(color: AppColors.primaryColor),
                                ),
                              ),
                              SizedBox(width: 30.w),
                              GestureDetector(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse('tel:(609)327-7992');
                                  if (await launchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    debugPrint('Could not launch phone dialer');
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Assets.icons.callIcon.svg(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 8.h),
                //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12.r),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.grey.shade300,
                //             blurRadius: 5,
                //             offset: Offset(2, 4))
                //       ]),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 10.w),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           flex: 3,
                //           child: CustomNetworkImage(
                //               border:
                //               Border.all(color: AppColors.primaryColor, width: 2.5),
                //               height: 48.h,
                //               width: 48.w,
                //               boxShape: BoxShape.circle,
                //               imageUrl:
                //               "https://randomuser.me/api/portraits/men/75.jpg"),
                //         ),
                //
                //         SizedBox(width: 10.w),
                //         Expanded(
                //             flex: 16,
                //             child: CustomTextField(
                //               controller: supportNoteCtrl,
                //               borderColor: Colors.grey,
                //               borderRadio: 30.r,
                //               hintText: "Support note for trip",
                //               prefixIcon: Assets.icons.messageIcon.svg(),
                //             )),
                //
                //
                //         SizedBox(width: 10.w),
                //         Expanded(
                //           flex: 3,
                //           child: Container(
                //             height: 60,
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: Colors.grey),
                //                 shape: BoxShape.circle, color: Colors.white),
                //             child: Padding(
                //               padding: EdgeInsets.all(8.r),
                //               child: Icon(
                //                 Icons.phone,
                //                 color: AppColors.primaryColor,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   )
                // ),
                SizedBox(
                  height: 40.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
