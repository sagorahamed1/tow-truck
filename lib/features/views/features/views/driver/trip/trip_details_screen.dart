import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_app_bar.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';
import 'package:towservice/widgets/custom_text_field.dart';

import '../../../../../../global/custom_assets/assets.gen.dart';

class TripDetailsScreen extends StatelessWidget {
  TripDetailsScreen({super.key});

  TextEditingController supportNoteCtrl = TextEditingController();

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(23.8103, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Trip Details"),
      body: Column(
        children: [


          SizedBox(
            height: 180.h,
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





          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
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
            padding: EdgeInsets.symmetric(vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Your Trip", fontWeight: FontWeight.w600),
                  Row(
                    children: [
                      Assets.icons.pickUpIcon.svg(),
                      CustomText(
                          text: " Block B, Banasree, Dhaka.",
                          fontWeight: FontWeight.w500)
                    ],
                  ),
                  Container(height: 20.h, width: 1.5.w, color: Colors.grey),
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
          CustomButtonTwo(
              height: 35.h,
              width: 345.w,
              color: Colors.transparent,
              borderRadius: 10.r,
              titlecolor: Color(0xffA17E3E),
              title: "Start Navigation",
              onpress: () {}),
          SizedBox(height: 26.h),







          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomNetworkImage(
                        border:
                        Border.all(color: AppColors.primaryColor, width: 2.5),
                        height: 48.h,
                        width: 48.w,
                        boxShape: BoxShape.circle,
                        imageUrl:
                        "https://randomuser.me/api/portraits/men/75.jpg"),
                  ),

                  SizedBox(width: 10.w),
                  Expanded(
                      flex: 16,
                      child: CustomTextField(
                        controller: supportNoteCtrl,
                        borderColor: Colors.grey,
                        borderRadio: 30.r,
                        hintText: "Support note for trip",
                        prefixIcon: Assets.icons.messageIcon.svg(),
                      )),


                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle, color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.phone,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),



        ],
      ),
    );
  }
}
