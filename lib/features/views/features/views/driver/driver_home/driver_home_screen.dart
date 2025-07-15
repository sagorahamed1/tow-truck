import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';
import 'package:towservice/widgets/custom_buttonTwo.dart';
import 'package:towservice/widgets/custom_network_image.dart';
import 'package:towservice/widgets/custom_text.dart';

import '../../../../../../widgets/customTripCard.dart';
import '../../../../../../widgets/custom_toggle_swicher.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool isOnline = false;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(23.8103, 90.4125);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Assets.icons.appLogo.svg(),
        ),
        title: CustomToggleSwitch(
          isOnline: isOnline,
          onChanged: (value) {
            setState(() {
              isOnline = value;
            });

            if (isOnline) {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return SizedBox(
                    height: 600.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(Icons.arrow_downward_rounded, color: Colors.black, size: 20.h)),
                              CustomText(text: "  Take your trip", fontSize: 20.h),
                            ],
                          ),


                          SizedBox(
                            height: 12.h
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Customtripcard();
                              },
                            ),
                          ),
                        ],
                      )


                    ),
                  );
                },
              );
            }
          },
        ),
        actions: [
          Stack(
            children: [
              CustomNetworkImage(
                  height: 41.h,
                  width: 41.w,
                  boxShape: BoxShape.circle,
                  imageUrl: "https://randomuser.me/api/portraits/men/75.jpg"),
              Positioned(
                top: 0,
                right: 0,
                child:
                    Assets.icons.verifyBedgeIcon.svg(height: 16.h, width: 16.w),
              )
            ],
          ),
          SizedBox(width: 20.w)
        ],
      ),
      body: Stack(
        children: [
          // The Map section
          SizedBox(
            height: Get.height,
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




          Positioned(
            child: Container(

            ),
          )







          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Row(
          //       children: [
          //         CustomNetworkImage(
          //           height: 41.h,
          //           width: 41.w,
          //           boxShape: BoxShape.circle,
          //           imageUrl:
          //               "https://randomuser.me/api/portraits/women/79.jpg",
          //         ),
          //         SizedBox(width: 12.w),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             CustomText(text: "Najma"),
          //             Row(
          //               children: [
          //                 CustomText(
          //                     text: "★★★★★",
          //                     color: Color(0xffFFCE31)),
          //                 SizedBox(width: 4.w),
          //                 CustomText(text: "5(2)"),
          //               ],
          //             ),
          //           ],
          //         ),
          //         Spacer(),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             CustomText(
          //                 text: "\$ 20", fontWeight: FontWeight.w600),
          //             CustomText(text: "3.3 km"),
          //           ],
          //         ),
          //       ],
          //     ),
          //     Divider(),
          //     Row(
          //       children: [
          //         Assets.icons.pickUpIcon.svg(),
          //         CustomText(
          //             text: " Pick Up", fontWeight: FontWeight.w500)
          //       ],
          //     ),
          //     CustomText(
          //         text: "King Fahd Road, Al Olaya, Riyadh 12212",
          //         fontSize: 11.h),
          //     Container(
          //         height: 20.h, width: 1.5.w, color: Colors.grey),
          //     Row(
          //       children: [
          //         Icon(Icons.location_on, size: 12.h),
          //         CustomText(
          //             text: " Drop off", fontWeight: FontWeight.w500)
          //       ],
          //     ),
          //     CustomText(
          //         text: "King Fahd Road, Al Olaya, Riyadh 12212",
          //         fontSize: 11.h),
          //     Divider(),
          //     Row(
          //       children: [
          //         Column(children: [
          //           CustomText(
          //               text: "Car Type",
          //               fontWeight: FontWeight.w500),
          //           Row(
          //             children: [
          //               Assets.icons.carIcon.svg(),
          //               CustomText(
          //                   text: "  Jeep",
          //                   fontWeight: FontWeight.w300)
          //             ],
          //           )
          //         ]),
          //         Spacer(),
          //         Column(
          //           children: [
          //             CustomText(
          //                 text: "Vehicle \nIssue",
          //                 fontWeight: FontWeight.w500,
          //                 right: 43.w),
          //             CustomText(
          //                 text: "Accident",
          //                 fontWeight: FontWeight.w300),
          //           ],
          //         ),
          //       ],
          //     ),
          //     CustomText(text: "Note", fontWeight: FontWeight.w500),
          //     CustomText(
          //         maxline: 4,
          //         textAlign: TextAlign.start,
          //         text:
          //             "Figma ipsum component variant main layer. Opacity text arrow link move plugin bold follower. Clip flows plugin figma blur frame frame.",
          //         fontWeight: FontWeight.w500),
          //     SizedBox(height: 8.h),
          //     CustomButtonTwo(title: "Accept Offer", onpress: () {})
          //   ],
          // ),
        ],
      ),
    );
  }
}
